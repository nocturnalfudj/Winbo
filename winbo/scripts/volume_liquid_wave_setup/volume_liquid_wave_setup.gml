/// Create can run while sibling room instances have not initialized yet.
/// Establish a complete body using only this instance's concrete fields.
function volume_liquid_wave_setup(){
	volume_liquid_body_build([id]);
}

/// Half-open edges include the last sprite pixel and join exactly adjacent
/// authored rectangles, without treating a corner or a dry gap as a connection.
function liquid_volume_at(_x, _y){
	for(var _i = 0; _i < instance_number(o_volume_liquid); _i++){
		var _v = instance_find(o_volume_liquid, _i);
		if(_x >= _v.bbox_left && _x < _v.bbox_right + 1
		&& _y >= _v.bbox_top && _y < _v.bbox_bottom + 1) return _v;
	}
	return noone;
}

function liquid_rects_connected(_a, _b){
	var _x = min(_a.right, _b.right) - max(_a.left, _b.left);
	var _y = min(_a.bottom, _b.bottom) - max(_a.top, _b.top);
	return (_x > 0 && _y >= 0) || (_x >= 0 && _y > 0);
}

/// Called after all room Create events, or for a later geometry/count change.
function volume_liquid_body_rebuild(){
	var _volumes = [];
	for(var _i = 0; _i < instance_number(o_volume_liquid); _i++)
		array_push(_volumes, instance_find(o_volume_liquid, _i));
	volume_liquid_body_build(_volumes);
}

function volume_liquid_body_build(_volumes){
	var _count = array_length(_volumes);
	var _room_count = instance_number(o_volume_liquid);
	var _rects = [], _assigned = array_create(_count, false);
	for(var _i = 0; _i < _count; _i++){
		var _v = _volumes[_i];
		array_push(_rects, {left: _v.bbox_left, top: _v.bbox_top,
			right: _v.bbox_right + 1, bottom: _v.bbox_bottom + 1});
		_v.liquid_geometry_left = _v.bbox_left;
		_v.liquid_geometry_top = _v.bbox_top;
		_v.liquid_geometry_right = _v.bbox_right;
		_v.liquid_geometry_bottom = _v.bbox_bottom;
		_v.liquid_geometry_count = _room_count;
	}
	for(var _seed = 0; _seed < _count; _seed++){
		if(_assigned[_seed]) continue;
		var _members = [_seed];
		_assigned[_seed] = true;
		for(var _q = 0; _q < array_length(_members); _q++){
			var _a = _members[_q];
			for(var _j = 0; _j < _count; _j++){
				if(_assigned[_j] || _volumes[_j].object_index != _volumes[_seed].object_index) continue;
				if(liquid_rects_connected(_rects[_a], _rects[_j])){
					_assigned[_j] = true;
					array_push(_members, _j);
				}
			}
		}
		var _body = {owner: _volumes[_seed], left: infinity, top: infinity,
			right: -infinity, bottom: -infinity, rects: [], cells: [], surfaces: []};
		var _xs = [];
		for(var _m = 0; _m < array_length(_members); _m++){
			var _r = _rects[_members[_m]];
			array_push(_body.rects, _r);
			array_push(_xs, _r.left, _r.right);
			_body.left = min(_body.left, _r.left);
			_body.top = min(_body.top, _r.top);
			_body.right = max(_body.right, _r.right);
			_body.bottom = max(_body.bottom, _r.bottom);
		}
		array_sort(_xs, true);
		// Split at every authored vertical edge, then merge overlapping vertical
		// intervals. These disjoint cells are the exact union, including holes.
		for(var _xi = 0; _xi < array_length(_xs) - 1; _xi++){
			var _left = _xs[_xi], _right = _xs[_xi + 1];
			if(_right <= _left) continue;
			var _intervals = [];
			for(var _ri = 0; _ri < array_length(_body.rects); _ri++){
				var _r = _body.rects[_ri];
				if(_r.left <= _left && _r.right >= _right)
					array_push(_intervals, {top: _r.top, bottom: _r.bottom});
			}
			array_sort(_intervals, function(_a, _b){ return _a.top - _b.top; });
			for(var _ii = 0; _ii < array_length(_intervals); _ii++){
				var _top = _intervals[_ii].top, _bottom = _intervals[_ii].bottom;
				while(_ii + 1 < array_length(_intervals) && _intervals[_ii + 1].top <= _bottom){
					_ii++;
					_bottom = max(_bottom, _intervals[_ii].bottom);
				}
				var _surface = -1;
				for(var _si = 0; _si < array_length(_body.surfaces); _si++){
					var _s = _body.surfaces[_si];
					if(_s.top == _top && _s.right == _left){
						_surface = _si;
						_s.right = _right;
						break;
					}
				}
				if(_surface < 0){
					_surface = array_length(_body.surfaces);
					array_push(_body.surfaces, {left: _left, right: _right, top: _top,
						segments: 0, dx: 0, displacement: [], velocity: []});
				}
				array_push(_body.cells, {left: _left, right: _right,
					top: _top, bottom: _bottom, surface: _surface});
			}
		}
		for(var _si = 0; _si < array_length(_body.surfaces); _si++){
			var _s = _body.surfaces[_si];
			_s.segments = max(8, ceil((_s.right - _s.left) / _volumes[_seed].wave_segment_px));
			_s.dx = (_s.right - _s.left) / _s.segments;
			_s.displacement = array_create(_s.segments + 1, 0);
			_s.velocity = array_create(_s.segments + 1, 0);
		}
		for(var _m = 0; _m < array_length(_members); _m++)
			_volumes[_members[_m]].liquid_body = _body;
	}
}

function liquid_surface_height(_surface, _x){
	var _u = clamp((_x - _surface.left) / (_surface.right - _surface.left), 0, 1);
	var _sample = _u * _surface.segments;
	var _i = floor(_sample), _j = min(_i + 1, _surface.segments);
	var _taper = power(max(0, sin(pi * _u)), wave_edge_power);
	return _surface.top + sin((2 * pi / wave_len_px) * _x + wave_phase) * wave_amp_px * _taper
		+ (wave_sim_enable ? lerp(_surface.displacement[_i], _surface.displacement[_j], frac(_sample)) : 0);
}

/// Return only actual exposed-top crossings, including a fast dash through a
/// shallow body. Internal rectangle edges never appear in this surface list.
function liquid_surface_crossing(_body, _x0, _y0, _x1, _y1, _up){
	if(_body == undefined || _y0 == _y1) return undefined;
	var _result = undefined, _first = infinity;
	for(var _i = 0; _i < array_length(_body.surfaces); _i++){
		var _s = _body.surfaces[_i];
		if(_up ? (_y0 < _s.top || _y1 >= _s.top) : (_y0 >= _s.top || _y1 < _s.top)) continue;
		var _fraction = (_s.top - _y0) / (_y1 - _y0);
		var _x = lerp(_x0, _x1, _fraction);
		if(_x >= _s.left && _x < _s.right && _fraction < _first){
			_first = _fraction;
			_result = {surface: _s, body: _body, x: _x};
		}
	}
	return _result;
}

/// Merge the segment's wet intervals instead of assuming membership in one
/// connected body means a straight dash never crosses a dry notch or hole.
function liquid_segment_submerged(_body, _x0, _y0, _x1, _y1){
	var _dx = _x1 - _x0, _dy = _y1 - _y0, _intervals = [];
	for(var _i = 0; _i < array_length(_body.rects); _i++){
		var _r = _body.rects[_i], _enter = 0, _leave = 1;
		if(_dx == 0){
			if(_x0 < _r.left || _x0 >= _r.right) continue;
		}
		else{
			var _a = (_r.left - _x0) / _dx, _b = (_r.right - _x0) / _dx;
			_enter = max(_enter, min(_a, _b));
			_leave = min(_leave, max(_a, _b));
		}
		if(_dy == 0){
			if(_y0 < _r.top || _y0 >= _r.bottom) continue;
		}
		else{
			var _a = (_r.top - _y0) / _dy, _b = (_r.bottom - _y0) / _dy;
			_enter = max(_enter, min(_a, _b));
			_leave = min(_leave, max(_a, _b));
		}
		if(_enter <= _leave) array_push(_intervals, {start: _enter, finish: _leave});
	}
	array_sort(_intervals, function(_a, _b){ return _a.start - _b.start; });
	var _covered = 0;
	for(var _i = 0; _i < array_length(_intervals); _i++){
		if(_intervals[_i].start > _covered) return false;
		_covered = max(_covered, _intervals[_i].finish);
		if(_covered >= 1) return true;
	}
	return false;
}

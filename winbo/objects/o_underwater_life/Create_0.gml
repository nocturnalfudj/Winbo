// Fish swim behind the water. Room-authored props share the water objects' draw layer.

#region Foliage
	// Foliage sprites placed on this layer sway in place with their base fixed.
	props_layer_name = "lyr_underwater_props";
	foliage_sprites = [
		spr_underwater_foliage_a,
		spr_underwater_foliage_a2,
		spr_underwater_foliage_b,
		spr_underwater_foliage_b2
	];
	foliage = [];
	// Tip travel as a share of the plant's height.
	foliage_sway_fraction = 0.035;
#endregion

#region Fish
	fish_sprites = [
		spr_underwater_fish_a,
		spr_underwater_fish_b,
		spr_underwater_fish_c,
		spr_underwater_fish_heart_a,
		spr_underwater_fish_heart_b,
		spr_underwater_fish_koi_a,
		spr_underwater_fish_koi_b,
		spr_underwater_fish_koi_c,
		spr_underwater_fish_seahorse_a,
		spr_underwater_fish_seahorse_b
	];
	fish = [];
	// One fish for every eight 320 px water tiles.
	fish_area_per_fish = 8 * 320 * 320;
	fish_scale_min = 0.75;
	fish_scale_max = 1.25;
	// Room pixels per frame at 60 fps.
	fish_speed_min = 36 / SECOND;
	fish_speed_max = 72 / SECOND;
	fish_seahorse_speed_factor = 0.45;
	fish_drift_min = 3 / SECOND;
	fish_drift_max = 9 / SECOND;
	// Fish keep their centre this far below the surface and this far from edges.
	fish_surface_margin = 96;
	fish_edge_margin = 24;
	fish_turn_time = 0.45 * SECOND;
	fish_spawn_attempts = 8;
	// Fish further than this beyond the view hold still until the camera nears.
	fish_active_margin = 960;
#endregion

/// The editor uses a foreground asset layer for placement. In play, submit its
/// sprites with the water objects so both receive the same filter in one pass.
underwater_props_setup = function() {
	var _props = layer_get_id(props_layer_name);
	if(!layer_get_visible(_props)) return;
	var _water = layer_get_id("lyr_water");
	var _elements = layer_get_all_elements(_props);
	for(var _i = 0; _i < array_length(_elements); _i++){
		var _element = _elements[_i];
		if(layer_get_element_type(_element) != layerelementtype_sprite) continue;
		var _sprite = layer_sprite_get_sprite(_element);
		if(array_get_index(foliage_sprites, _sprite) < 0){
			layer_element_move(_element, _water);
			continue;
		}
		var _index = floor(layer_sprite_get_index(_element));
		var _width = sprite_get_width(_sprite);
		var _height = sprite_get_height(_sprite);
		var _xscale = layer_sprite_get_xscale(_element);
		var _yscale = layer_sprite_get_yscale(_element);
		var _angle = layer_sprite_get_angle(_element);
		var _sway = _height * abs(_yscale) * foliage_sway_fraction;
		var _radius = max(_width * abs(_xscale), _height * abs(_yscale)) + _sway;
		array_push(foliage, {
			sprite: _sprite,
			frame: _index,
			x: layer_sprite_get_x(_element),
			y: layer_sprite_get_y(_element),
			xscale: _xscale,
			yscale: _yscale,
			rot_cos: dcos(_angle),
			rot_sin: dsin(_angle),
			colour: layer_sprite_get_blend(_element),
			alpha: layer_sprite_get_alpha(_element),
			// The sprite origin is the bottom edge. A shear moves its tip while
			// leaving every point along that edge in its authored position.
			height: _height,
			sway: _sway,
			phase: random(2 * pi) + layer_sprite_get_x(_element) * 0.002,
			rate: 2 * pi / (random_range(3, 5) * SECOND),
			radius: _radius
		});
		layer_sprite_destroy(_element);
	}
	if(array_length(foliage) > 0) layer_script_end(_water, underwater_foliage_draw_visible);
	if(array_length(layer_get_all_elements(_props)) == 0) layer_enable_fx(_props, false);
};

underwater_foliage_draw_visible = function(){
	if(event_type != ev_draw || event_number != ev_draw_normal) return;
	var _camera = view_camera[0];
	var _view_left = camera_get_view_x(_camera);
	var _view_top = camera_get_view_y(_camera);
	var _view_right = _view_left + camera_get_view_width(_camera);
	var _view_bottom = _view_top + camera_get_view_height(_camera);

	for(var _i = 0; _i < array_length(foliage); _i++){
		var _plant = foliage[_i];
		if(_plant.x + _plant.radius < _view_left || _plant.x - _plant.radius > _view_right
		|| _plant.y + _plant.radius < _view_top || _plant.y - _plant.radius > _view_bottom) continue;
		underwater_foliage_draw(_plant);
	}
};

underwater_foliage_draw = function(_plant) {
	var _tip = _plant.sway * (sin(_plant.phase) + 0.3 * sin(2.1 * _plant.phase + 1));
	var _shear = -_tip / _plant.height;
	var _local = matrix_build_identity();
	_local[0] = _plant.xscale * _plant.rot_cos;
	_local[1] = -_plant.xscale * _plant.rot_sin;
	_local[4] = _plant.yscale * _plant.rot_sin + _shear * _plant.rot_cos;
	_local[5] = _plant.yscale * _plant.rot_cos - _shear * _plant.rot_sin;
	_local[12] = _plant.x;
	_local[13] = _plant.y;
	var _world = matrix_get(matrix_world);
	matrix_set(matrix_world, matrix_multiply(_local, _world));
	draw_sprite_ext(_plant.sprite, _plant.frame, 0, 0, 1, 1, 0, _plant.colour, _plant.alpha);
	matrix_set(matrix_world, _world);
};

/// Called once the room's water bodies are final (liquid Room Start).
underwater_fish_spawn = function() {
	fish = [];
	var _bodies = [];
	with(o_volume_water){
		if(liquid_body.owner == id) array_push(_bodies, liquid_body);
	}
	for(var _b = 0; _b < array_length(_bodies); _b++){
		var _cells = _bodies[_b].cells;
		var _area = 0;
		for(var _c = 0; _c < array_length(_cells); _c++)
			_area += (_cells[_c].right - _cells[_c].left) * (_cells[_c].bottom - _cells[_c].top);
		repeat(round(_area / fish_area_per_fish)) underwater_fish_place(_cells, _area);
	}
};

underwater_fish_place = function(_cells, _area) {
	var _sprite = fish_sprites[irandom(array_length(fish_sprites) - 1)];
	var _seahorse = _sprite == spr_underwater_fish_seahorse_a || _sprite == spr_underwater_fish_seahorse_b;
	var _scale = random_range(fish_scale_min, fish_scale_max);
	var _dir = choose(-1, 1);
	var _fish = {
		sprite: _sprite,
		x: 0,
		y: 0,
		dir: _dir,
		facing: _dir,
		scale: _scale,
		half_width: sprite_get_width(_sprite) * _scale * 0.5,
		half_height: sprite_get_height(_sprite) * _scale * 0.5,
		cruise: random_range(fish_speed_min, fish_speed_max) * (_seahorse ? fish_seahorse_speed_factor : 1),
		pace: 0,
		drift: random_range(fish_drift_min, fish_drift_max) * choose(-1, 1),
		phase: random(2 * pi),
		bob_speed: 2 * pi / (random_range(2, 3.5) * SECOND),
		bob_amount: _seahorse ? 10 : 5,
		tilt: _seahorse ? 0 : 4,
		turn_countdown: 0,
		cells: _cells,
		cell: 0
	};
	_fish.pace = _fish.cruise;
	repeat(fish_spawn_attempts){
		// Area-weighted cell, then a point that clears the surface and edges.
		var _pick = random(_area);
		var _cell = _cells[0];
		for(var _c = 0; _c < array_length(_cells); _c++){
			_cell = _cells[_c];
			_pick -= (_cell.right - _cell.left) * (_cell.bottom - _cell.top);
			if(_pick < 0) break;
		}
		var _x = random_range(_cell.left, _cell.right);
		var _y = random_range(_cell.top + fish_surface_margin, _cell.bottom - fish_edge_margin);
		if(underwater_fish_clear(_fish, _x, _y)
		&& underwater_fish_clear(_fish, _x + _fish.half_width + fish_edge_margin, _y)
		&& underwater_fish_clear(_fish, _x - _fish.half_width - fish_edge_margin, _y)
		&& underwater_fish_clear(_fish, _x, _y - _fish.half_height)
		&& underwater_fish_clear(_fish, _x, _y + _fish.half_height + fish_edge_margin)){
			_fish.x = _x;
			_fish.y = _y;
			array_push(fish, _fish);
			return;
		}
	}
};

/// Inside the actual wet union, below the surface margin, and not in a wall.
underwater_fish_clear = function(_fish, _x, _y) {
	var _cells = _fish.cells;
	var _cell = _cells[_fish.cell];
	if(!(_x >= _cell.left && _x < _cell.right
	&& _y >= _cell.top + fish_surface_margin && _y < _cell.bottom)){
		var _found = -1;
		for(var _c = 0; _c < array_length(_cells); _c++){
			_cell = _cells[_c];
			if(_x >= _cell.left && _x < _cell.right
			&& _y >= _cell.top + fish_surface_margin && _y < _cell.bottom){
				_found = _c;
				break;
			}
		}
		if(_found < 0) return false;
		_fish.cell = _found;
	}
	return !position_meeting(_x, _y, o_solid);
};

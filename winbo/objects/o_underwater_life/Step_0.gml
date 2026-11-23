var _dt = global.delta_time_factor_scaled;
var _camera = view_camera[0];
var _view_left = camera_get_view_x(_camera);
var _view_top = camera_get_view_y(_camera);
var _view_right = _view_left + camera_get_view_width(_camera);
var _view_bottom = _view_top + camera_get_view_height(_camera);

for(var _i = 0; _i < array_length(foliage); _i++){
	var _plant = foliage[_i];
	_plant.phase += _plant.rate * _dt;
}

var _active_left = _view_left - fish_active_margin;
var _active_top = _view_top - fish_active_margin;
var _active_right = _view_right + fish_active_margin;
var _active_bottom = _view_bottom + fish_active_margin;
var _facing_step = 2 * _dt / fish_turn_time;
for(var _i = 0; _i < array_length(fish); _i++){
	var _fish = fish[_i];
	if(_fish.x < _active_left || _fish.x > _active_right
	|| _fish.y < _active_top || _fish.y > _active_bottom) continue;

	_fish.phase += _fish.bob_speed * _dt;
	_fish.turn_countdown = max(0, _fish.turn_countdown - _dt);
	_fish.facing = (_fish.facing < _fish.dir)
		? min(_fish.dir, _fish.facing + _facing_step)
		: max(_fish.dir, _fish.facing - _facing_step);
	// Ease back up to cruising speed after a turn.
	_fish.pace = lerp(_fish.pace, _fish.cruise, 1 - power(0.96, _dt));

	// Turn around at a wall, a dry edge, or a step up out of the water.
	var _x = _fish.x + _fish.dir * _fish.pace * _dt;
	var _nose = _x + _fish.dir * (_fish.half_width + fish_edge_margin);
	if(!underwater_fish_clear(_fish, _nose, _fish.y)){
		_x = _fish.x;
		if(_fish.turn_countdown <= 0){
			_fish.dir = -_fish.dir;
			_fish.pace *= 0.25;
			_fish.turn_countdown = fish_turn_time;
		}
	}

	// Slow vertical wander that reverses below the surface and above the floor.
	var _y = _fish.y + _fish.drift * _dt;
	var _probe = _y + ((_fish.drift < 0) ? -_fish.half_height : _fish.half_height + fish_edge_margin);
	if(!underwater_fish_clear(_fish, _x, _probe)){
		_y = _fish.y;
		_fish.drift = -_fish.drift;
	}
	_fish.x = _x;
	_fish.y = _y;
}

var _camera = view_camera[0];
var _view_left = camera_get_view_x(_camera);
var _view_top = camera_get_view_y(_camera);
var _view_right = _view_left + camera_get_view_width(_camera);
var _view_bottom = _view_top + camera_get_view_height(_camera);

// The art faces left; a turn squeezes through zero width instead of snapping.
for(var _i = 0; _i < array_length(fish); _i++){
	var _fish = fish[_i];
	if(_fish.x + _fish.half_width < _view_left || _fish.x - _fish.half_width > _view_right
	|| _fish.y + _fish.half_height < _view_top - 16 || _fish.y - _fish.half_height > _view_bottom + 16) continue;
	draw_sprite_ext(_fish.sprite, 0, _fish.x, _fish.y + sin(_fish.phase) * _fish.bob_amount,
		-_fish.facing * _fish.scale, _fish.scale, cos(_fish.phase) * _fish.tilt * _fish.dir,
		c_white, 1);
}

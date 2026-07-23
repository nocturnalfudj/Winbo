var _delta_time_scaled;
_delta_time_scaled = global.delta_time_factor_scaled;

x += drift_x * _delta_time_scaled;
y += drift_y * _delta_time_scaled;
sway_phase += sway_speed * _delta_time_scaled;
image_angle = sin(sway_phase) * 12;

image_index += image_speed * _delta_time_scaled;
if(image_index >= sprite_get_number(decor_sprite)) {
	image_index = 0;
}

var _camera, _view_x, _view_y, _view_w, _view_h;
_camera = view_camera[0];
_view_x = camera_get_view_x(_camera);
_view_y = camera_get_view_y(_camera);
_view_w = camera_get_view_width(_camera);
_view_h = camera_get_view_height(_camera);
if(x < _view_x - 192 || x > _view_x + _view_w + 192
	|| y < _view_y - 192 || y > _view_y + _view_h + 192) {
	instance_destroy();
}

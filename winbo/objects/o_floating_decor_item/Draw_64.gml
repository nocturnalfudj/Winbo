if(draw_in_gui) {
	var _camera = view_camera[0];
	var _view_x = camera_get_view_x(_camera);
	var _view_y = camera_get_view_y(_camera);
	var _view_w = camera_get_view_width(_camera);
	var _view_h = camera_get_view_height(_camera);
	var _gui_scale_x = display_get_gui_width() / _view_w;
	var _gui_scale_y = display_get_gui_height() / _view_h;
	var _gui_x = (x - _view_x) * _gui_scale_x;
	var _gui_y = (
		y + sin(sway_phase * 1.7) * sway_amount - _view_y
	) * _gui_scale_y;

	draw_sprite_ext(
		decor_sprite,
		floor(image_index),
		_gui_x,
		_gui_y,
		image_xscale * _gui_scale_x,
		image_yscale * _gui_scale_y,
		image_angle,
		c_white,
		image_alpha
	);
}

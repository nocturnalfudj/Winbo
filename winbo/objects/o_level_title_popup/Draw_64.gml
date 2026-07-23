var _scale_x, _scale_y;
if(title_delay_countdown > 0) exit;
_scale_x = display_get_gui_width() / 1920;
_scale_y = display_get_gui_height() / 1080;
draw_sprite_ext(
	spr_level_title_deforest_station,
	min(floor(title_frame),title_frame_count - 1),
	0,
	0,
	_scale_x,
	_scale_y,
	0,
	c_white,
	1
);

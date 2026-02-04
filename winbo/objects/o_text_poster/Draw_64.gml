if(gui && camera_visible_gui){
	var _string,_sep,_width,_width_actual;
	_string = text_final_string;
	_sep = sep;
	_width = width;
	_width_actual = width_actual;
	
	var _gui_scale;
	_gui_scale = o_ui.gui_scale;

	var _x,_y,_angle,_colour,_alpha,_scale_x,_scale_y;
	_x = x * _gui_scale;
	_y = y * _gui_scale;
	_alpha = image_alpha;
	_colour = image_blend;
	_angle = image_angle;
	_scale_x = image_xscale * _gui_scale;
	_scale_y = image_yscale * _gui_scale;
	
	if(shadow_enable){
		var _shadow_x,_shadow_y;
		_shadow_x = _x + shadow_x*_scale_x;
		_shadow_y = _y + shadow_y*_scale_y;
		draw_text_ext_transformed_ags(_shadow_x,_shadow_y,_string,_sep,_width_actual,_scale_x,_scale_y,_angle,shadow_c,_alpha*shadow_alpha,alignment_h,alignment_v,font);
	}

	draw_text_ext_transformed_ags(_x,_y,_string,_sep,_width_actual,_scale_x,_scale_y,_angle,_colour,_alpha,alignment_h,alignment_v,font);
}
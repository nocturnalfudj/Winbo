if(gui && camera_visible_gui){
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
	
	if(sprite_current!=noone){
		draw_sprite_ext_ags(sprite_current,0,_x,_y,_scale_x,_scale_y,_angle,_colour,_alpha);
	}
}
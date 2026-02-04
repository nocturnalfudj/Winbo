if((gui) && ((fade_full_screen) || (camera_visible_gui))){
	var _gui_scale;
	_gui_scale = o_ui.gui_scale;
	
	var _x,_y,_alpha,_colour;
	//var _angle,_scale_x,_scale_y;
	_x = x * _gui_scale;
	_y = y * _gui_scale;
	_alpha = image_alpha * fade_factor;
	_colour = image_blend;
	//_angle = image_angle;
	//_scale_x = image_xscale * _gui_scale;
	//_scale_y = image_yscale * _gui_scale;
		
	draw_set_colour(_colour);
	draw_set_alpha(_alpha);
	
	if(fade_full_screen){
		var _width,_height;
		with(o_camera){
			_width = width_ini * _gui_scale;
			_height = height_ini * _gui_scale;
		}
		
		if(blur_area_id != noone){
			blur_area_draw(blur_area_id, application_surface, BLUR_TYPE.GAUSSIAN,0,0,_width,_height, 0, 0, image_alpha*0.05, 0.25,,,image_alpha);
		}
		
		draw_rectangle(0,0,_width,_height,false);
	}
	else{
		var _width_half,_height_half;
		_width_half = width_half * _gui_scale;
		_height_half = height_half * _gui_scale;
		
		var _x1,_y1,_x2,_y2;
		_x1 = _x - _width_half;
		_x2 = _x + _width_half;
			
		_y1 = _y - _height_half;
		_y2 = _y + _height_half;
		
		//TODO - Figure out why using variables for the width/height of the blur doesn't work, but using literal numbers do
		//blur_area_draw(blur_area_id, application_surface, BLUR_TYPE.GAUSSIAN,_x1,_y1,_width_half*2,_height_half*2, 0, 0, image_alpha*0.05, 0.25,,,image_alpha);
		draw_rectangle(_x1,_y1,_x2,_y2,false);
	}
	
	draw_set_alpha(1);
}
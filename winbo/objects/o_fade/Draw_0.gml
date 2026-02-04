if((!gui) && ((fade_full_screen) || (camera_visible_check()))){
	var _x,_y,_alpha,_colour;
	//var _angle,_scale_x,_scale_y;
	
	_x = x;
	_y = y;
	_alpha = image_alpha * fade_factor;
	_colour = image_blend;
	//_angle = image_angle;
	//_scale_x = image_xscale;
	//_scale_y = image_yscale;
		
	draw_set_colour(_colour);
	draw_set_alpha(_alpha);
		
	if(fade_full_screen){
		var _width,_height;
		var _camera_x,_camera_y;
		with(o_camera){
			_width = width;
			_height = height;
			_camera_x = start_x;
			_camera_y = start_y;
		}
		if(!fade_follow_camera)
			draw_rectangle(0,0,_width,_height,false);
		else{
			var _buffer;
			_buffer = 30;
			draw_rectangle(_camera_x - _buffer,_camera_y - _buffer,_camera_x+_width + _buffer,_camera_y+_height + _buffer,false);
		}
	}
	else{
		var _x1,_y1,_x2,_y2;
		_x1 = _x - width_half;
		_x2 = _x + width_half;
			
		_y1 = _y - height_half;
		_y2 = _y + height_half;
		
		draw_rectangle(_x1,_y1,_x2,_y2,false);
	}
		
	draw_set_alpha(1);
}
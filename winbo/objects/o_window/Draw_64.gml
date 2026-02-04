if(gui && camera_visible_gui){
	var _gui_scale;
	_gui_scale = o_ui.gui_scale;
	
	var _camera_width,_camera_height;
	_camera_width = o_camera.width;
	_camera_height = o_camera.height;
	
	var _x,_y,_angle,_colour,_alpha,_scale_x,_scale_y;
	_x = x * _gui_scale;
	_y = y * _gui_scale;
	_alpha = image_alpha;
	_colour = image_blend;
	_angle = image_angle;
	_scale_x = image_xscale * _gui_scale;
	_scale_y = image_yscale * _gui_scale;
	
	//Draw the Window Background
	if(sprite_current!=noone)
		draw_sprite_ext_ags(sprite_current,0,_x,_y,_scale_x,_scale_y,_angle,_colour,_alpha);
	
	//If Surface has been lost recreate it
	if(!surface_exists(surface)){
		surface = surface_create(_camera_width,_camera_height);
		window_surface_redraw_set(2);
	}
	
	//Draw the Surface
	if(surface_exists(surface)){
		if(surface_redraw){
			surface_set_target(surface);
			draw_clear_alpha(c_black,0);
			
			for(var _i=0;_i<surface_draw_size;_i++){
				with(surface_draw[| _i]){
					event_perform(ev_draw,ev_gui);
				}
			}
			
			surface_reset_target();
		}
		
		var _x_surface,_y_surface,_left,_top,_width,_height;
		_x_surface = _x + (surface_x + surface_border_left)*_scale_x;
		_y_surface = _y + (surface_y + surface_border_top)*_scale_y;
		_width = (width - surface_border_right)*_scale_x;
		_height = (height - surface_border_bottom)*_scale_y;
		draw_surface_part_ext(surface,_x_surface,_y_surface,_width,_height,_x_surface,_y_surface,1,1,_colour,_alpha);
	}
	
	//Title System Draw
	title_system_draw(_x,_y,_angle,_colour,_alpha,_scale_x,_scale_y);
}
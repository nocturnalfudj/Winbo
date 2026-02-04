#region Console
	var _x,_y,_angle,_colour,_alpha,_scale_x,_scale_y;
	
	var _gui_scale;
	_gui_scale = o_ui.gui_scale;
		
	_x = x * _gui_scale;
	_y = (y - CONSOLE_TXTFLD_LOG_BUFF_Y + text_field_height) * _gui_scale;
	_alpha = image_alpha;
	_colour = image_blend;
	_angle = image_angle;
	_scale_x = image_xscale * _gui_scale;
	_scale_y = image_yscale * _gui_scale;
	
	var _width,_height;
	_width = width * _scale_x;
	_height = height * _scale_y;
		
	//Fade
	draw_set_colour(_colour);
	draw_set_alpha(_alpha*0.75);
	draw_rectangle(0,0,_width,_height,0);
	
	//Autofill Help
	if(command_autofill_help_enable){
		var _separator_line_width;
		_separator_line_width = 1;
		
		draw_set_colour(c_white);
		draw_set_alpha(_alpha);
		draw_rectangle(_width,0,_width + _separator_line_width,_height,0);
		
		draw_set_colour(_colour);
		draw_set_alpha(_alpha*0.75);
		draw_rectangle(_width + _separator_line_width,0,_width + _separator_line_width +_width,_height,0);
	}
		
	#region Log
		draw_set_halign(CONSOLE_LOG_ALIGN_H);
		draw_set_valign(CONSOLE_LOG_ALIGN_V);
		draw_set_font(CONSOLE_LOG_FONT);
		
		draw_set_alpha(_alpha);
		
		var _log_sep,_log_sep_message;
		_log_sep = log_sep;
		_log_sep_message = log_sep_message * _scale_y;
		
		var _list_size,_string;
		_list_size = ds_list_size(log);
		
		var _log_colour;
		for(var _i=log_draw_start_pos;_i<_list_size;_i++){
			_string = log[| _i];
			_log_colour = log_colour[| _i];
			
			_y -= (max(string_height_ext(_string,_log_sep,width),_log_sep)) * _scale_y;
			
			_log_colour ??= c_white;
			draw_set_color(_log_colour);
			
			draw_text_ext_transformed(_x,_y,_string,_log_sep,width,_scale_x,_scale_y,_angle);
			
			_y -= _log_sep_message;
		
			if(_y < 0) break;
		}
		draw_set_alpha(1);
	#endregion
#endregion

#region ID Show
	if(id_show != IDShow.off){
		if(id_show == IDShow.everything){
			console_draw_id_show(all);
		}
		else if (id_show == IDShow.mouse){
			var _inst,_x,_y;
			with(o_ui){
				_x = mouse_gui_scale_inverted[0].x;
				_y = mouse_gui_scale_inverted[0].y;
			}
			_inst = instance_position(_x,_y,all);
			console_draw_id_show_ui(_inst);
			
			_x = mouse_x;
			_y = mouse_y;
			_inst = instance_position(_x,_y,all);
			console_draw_id_show(_inst);
		}
	}
#endregion
#region Screenshots
	#region Dev Screenshot
		if(BUILD_TYPE_DEV){
			//If Screenshotting
			if(screenshot_record == 1){
				//Stop Drawing to GUI Surface
				surface_reset_target();
		
				//Create Temporary Screenshot Surface
				var _surface,_width,_height;
				_width = resolution[resolution_slot_current][RES_W];
				_height = resolution[resolution_slot_current][RES_H];
				_surface = surface_create(_width,_height);
		
				#region Prepare Screenshot Surface
					//Draw to Screenshot Surface
					surface_set_target(_surface);
		
					//Draw Application Surface
					draw_surface(application_surface,0,0);
			
					//Draw GUI Surface with Alpha Write Disabled
					gpu_set_colorwriteenable(true, true, true, false);
					draw_surface(gui_surface,0,0);
					gpu_set_colorwriteenable(true, true, true, true);
			
					//Reset Surface Target
					surface_reset_target();
				#endregion
		
				//Timezone & Datetime
				var _current_datetime;
				date_set_timezone(timezone_local);
				_current_datetime = date_current_datetime();
		
				//Prepare File Name
				var _screenshot_str,_file_dir;
				_screenshot_str =	NAME + "_" + VERSION + "_screenshot_" + string(screenshot_num) + "_"
									+ string(date_get_year(_current_datetime)) + "_"
									+ string(date_get_month(_current_datetime)) + "_"
									+ string(date_get_day(_current_datetime)) + "_"
									+ string(date_get_hour(_current_datetime)) + "_"
									+ string(date_get_minute(_current_datetime)) + "_"
									+ string(date_get_second(_current_datetime));
				_file_dir = "screenshots/" + _screenshot_str + ".png";
		
				//Save Screenshot Surface
				_file_dir = get_save_filename_ext("screenshot|*.png", _screenshot_str, working_directory, "Screenshot");
				//screen_save(_file_dir);
				surface_save(_surface,_file_dir);
		
				//Remove Screenshot Surface From Memory
				surface_free(_surface);
		
				//Print Saved Screenshot
				sdm("Screenshot saved: " + _file_dir);
		
				//Increase Screenshot Number
				screenshot_num++;
		
				//Timezone
				date_set_timezone(timezone_utc);
		
				//Finish Screenshotting
				screenshot_record = false;
			}
	
			//Screenshot Pressed
			if(keyboard_check_pressed(vk_f12)){
				//Start Screenshotting
				screenshot_record = true;
			}
		}
	#endregion
	
	#region Normal Screenshot
		//Screenshot Pressed
		if(keyboard_check_pressed(vk_f11)){
			//Timezone & Datetime
			var _current_datetime;
			date_set_timezone(timezone_local);
			_current_datetime = date_current_datetime();
		
			//Prepare File Name
			var _screenshot_str,_file_dir;
			_screenshot_str =	NAME + "_" + VERSION + "_screenshot_" + string(screenshot_num) + "_"
								+ string(date_get_year(_current_datetime)) + "_"
								+ string(date_get_month(_current_datetime)) + "_"
								+ string(date_get_day(_current_datetime)) + "_"
								+ string(date_get_hour(_current_datetime)) + "_"
								+ string(date_get_minute(_current_datetime)) + "_"
								+ string(date_get_second(_current_datetime));
			_file_dir = "screenshots/" + _screenshot_str + ".png";
		
			//Save Screenshot Surface
			_file_dir = get_save_filename_ext("screenshot|*.png", _screenshot_str, working_directory, "Screenshot");
			screen_save(_file_dir);
		}
	#endregion
#endregion

#region GIF Recording
	if(gif_record){
		if(gif == -1){
			gif_record = false;
		}
		else{	
			//Stop Drawing to GIF GUI Surface
			surface_reset_target();
					
			//Draw GUI Surface Normally
			draw_surface(gui_surface,0,0);
					
			//Check if GIF Surface Exists
			//If Not Then Create it
			if(!surface_exists(gif_surface)){
				gif_surface = surface_create(gif_width,gif_height);
			}
					
			//Set Target Surface to GIF Surface
			//And Clear it
			surface_set_target(gif_surface);
			draw_clear_alpha(c_black,0);
					
			//Draw GUI and Application Surfaces to GIF Surface
			draw_surface_stretched(application_surface,0,0,gif_width,gif_height);
			draw_surface_stretched(gui_surface,0,0,gif_width,gif_height);
					
			//Stop Drawing to GIF Surface
			surface_reset_target();
					
			//Add GIF Surface to GIF
			gif_add_surface(gif,gif_surface,2,0,0,2);
		}
	}

	#region GIF Recording and Saving
		if(keyboard_check_pressed(vk_f12)){
			gif_record = !gif_record;
	
			if(gif_record){
				#region Start Recording GIF
					gif_width = resolution[resolution_slot_current][RES_W]*GIF_SCALE;
					gif_height = resolution[resolution_slot_current][RES_H]*GIF_SCALE;
					
					gif = gif_open(gif_width,gif_height);
				#endregion
			}
			else{
				#region Save GIF
					if(gif != -1){
						//Timezone & Datetime
						var _current_datetime;
						date_set_timezone(timezone_local);
						_current_datetime = date_current_datetime();
		
		
						var _gif_str,_file_dir;
						_gif_str =	NAME + "_" + VERSION + "_gif_" + string(gif_num) + "_"
											+ string(date_get_year(_current_datetime)) + "_"
											+ string(date_get_month(_current_datetime)) + "_"
											+ string(date_get_day(_current_datetime)) + "_"
											+ string(date_get_hour(_current_datetime)) + "_"
											+ string(date_get_minute(_current_datetime)) + "_"
											+ string(date_get_second(_current_datetime));
						_file_dir = "gifs/" + _gif_str + ".gif";
		
						_file_dir = get_save_filename_ext("gif|*.gif", _gif_str, working_directory, "GIF");
						gif_save(gif,_file_dir);
						sdm("GIF saved: " + _file_dir);
		
						gif_num++;
		
						//Timezone
						date_set_timezone(timezone_utc);
					}
				#endregion
			}
		}
	#endregion
#endregion

// Done with the shader (this is really just shader_reset)!
bktglitch_deactivate();

#region Level End White Flash
	// Draw white flash for level end
	if(global.game_state == GameState.level_end_flash){
		// Master always exists, no need to check
		if(o_master.level_end_flash_alpha > 0){
			// Draw full-screen white rectangle
			draw_set_color(c_white);
			draw_set_alpha(o_master.level_end_flash_alpha);
			draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
			draw_set_alpha(1);
		}
	}
#endregion

#region Level End Fade to Black
	if(o_master.level_end_fade_alpha > 0){
		draw_set_color(c_black);
		draw_set_alpha(o_master.level_end_fade_alpha);
		draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
		draw_set_alpha(1);
	}
#endregion
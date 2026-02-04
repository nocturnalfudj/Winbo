#region VFX
	if(glitch_enable){
		var _glitch_magnitude;
		_glitch_magnitude = glitch_magnitude.current * glitch_setting_current[GlitchSetting.intensity];
		
		if(_glitch_magnitude > 0){
		
			#region Ensure Glitch Surfaces Exist
				if(!surface_exists(glitch_surface)){
					var _surface_width,_surface_height;
					_surface_width = surface_get_width(application_surface);
					_surface_height = surface_get_height(application_surface);
		
					glitch_surface = surface_create(_surface_width,_surface_height);
				}
			#endregion
	
			#region Glitch Shader
				surface_set_target(glitch_surface);
	
				// Activating the shader
				bktglitch_activate();
				
				//bktglitch_set_resolution_of_gui();

				// Setting the overall intensity of the effect
				if(glitch_shader_update){
					bktglitch_set_line_speed(			glitch_setting_current[GlitchSetting.line_speed]);		
					bktglitch_set_line_shift(			glitch_setting_current[GlitchSetting.line_shift]);
					bktglitch_set_line_resolution(		glitch_setting_current[GlitchSetting.line_resolution]);
					bktglitch_set_line_vertical_shift(	glitch_setting_current[GlitchSetting.line_vertical_shift]);
					bktglitch_set_line_drift(			glitch_setting_current[GlitchSetting.line_drift]);
					bktglitch_set_jumble_speed(			glitch_setting_current[GlitchSetting.jumble_speed]);
					bktglitch_set_jumble_shift(			glitch_setting_current[GlitchSetting.jumble_shift]);
					bktglitch_set_jumble_resolution(	glitch_setting_current[GlitchSetting.jumble_resolution]);
					bktglitch_set_jumbleness(			glitch_setting_current[GlitchSetting.jumbleness]);
					bktglitch_set_channel_dispersion(	glitch_setting_current[GlitchSetting.channel_dispersion]);
					bktglitch_set_channel_shift(		glitch_setting_current[GlitchSetting.channel_shift]);	
					bktglitch_set_noise_level(			glitch_setting_current[GlitchSetting.noise_level]);
					bktglitch_set_shakiness(			glitch_setting_current[GlitchSetting.shakiness]);	
					bktglitch_set_rng_seed(				glitch_setting_current[GlitchSetting.rng_seed]);
					bktglitch_set_intensity(			_glitch_magnitude);
					//bktglitch_set_time(				glitch_setting_target[GlitchSetting.time]);
					//bktglitch_set_resolution(			glitch_setting_target[GlitchSetting.resolution]);	
				}
				
				var _gui_scale,_position_scale_factor;
				_gui_scale = 1;//o_ui.gui_scale;

				//Draw the Application Surface
				draw_surface_ext(application_surface,0,0,_gui_scale,_gui_scale,0,c_white,1);

				//Reset Shader
				shader_reset();
			
				//Stop Targeting Glitch Surface
				surface_reset_target();
			#endregion
		
			//Update Application Surface
			surface_copy(application_surface,0,0,glitch_surface);
		}
	}
	
	//Vignette Noise Enabled
	if(vignette_noise_enable){
		//Set Shader
		shader_set(sh_vignette_noise);
		
		//Update Shader Seed
		shader_set_uniform_f(vignette_noise_shader_uniform_vignette_random_seed, random_range(0.5,0.6));
		
		//Update Shader Values
		if(vignette_noise_shader_update){
			//Set Values
			shader_set_uniform_f(vignette_noise_shader_uniform_vignette_colour,
									vignette_noise_colour_current[VignetteNoiseColour.red],
									vignette_noise_colour_current[VignetteNoiseColour.green],
									vignette_noise_colour_current[VignetteNoiseColour.blue]); //R,G,B - 0 to 255
									
			shader_set_uniform_f(vignette_noise_shader_uniform_settings,
									vignette_noise_setting_setting_current[VignetteNoiseSetting.inner_circle_size],
									vignette_noise_setting_setting_current[VignetteNoiseSetting.outter_circle_size],
									(vignette_noise_setting_setting_current[VignetteNoiseSetting.noise_strength] + filter_setting[CameraFilter.noise_additional]) * filter_setting[CameraFilter.noise_intensity],
									1); //vignette inner circle size, vignette outter circle size, noise strength, noise enable (1 or 0 only).
			
			//Update Complete
			vignette_noise_shader_update = false;
		}
		
		//Draw Application Surface
		draw_surface(application_surface,0,0);
		
		//Reset Shader
		shader_reset();
	}
	else{
		//Draw the Application Surface
		draw_surface(application_surface, 0, 0);
	}
#endregion

#region Recording
	if(gif_record || screenshot_record){
		var _width,_height;
		_width = resolution[resolution_slot_current][RES_W];
		_height = resolution[resolution_slot_current][RES_H];
			
		if(!surface_exists(gui_surface)){
			gui_surface = surface_create(_width,_height);
		}
		
		surface_set_target(gui_surface);
		draw_clear_alpha(c_black,0);
	}
#endregion
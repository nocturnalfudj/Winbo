#region VFX
	#region Lighting
		if(lighting_enable){
			var _lighting_scale;
			_lighting_scale = 0.5;
			
			#region Ensure Lighting Surfaces Exist
				//Get Application Surface Dimensions
				var _surface_width,_surface_height,_surface_width_scaled,_surface_height_scaled;
				_surface_width = surface_get_width(application_surface);
				_surface_height = surface_get_height(application_surface)
				_surface_width_scaled = floor(_surface_width*_lighting_scale);
				_surface_height_scaled = floor(_surface_height*_lighting_scale);
			
				if(!surface_exists(lighting_bloom_surface)){
					lighting_bloom_surface = surface_create(_surface_width, _surface_height);
				}
		
				if(!surface_exists(lighting_lights_surface)){
					lighting_lights_surface = surface_create(_surface_width_scaled,_surface_height_scaled);
					lighting_lights_surface_texture = surface_get_texture(lighting_lights_surface);
				}
				
				if(!surface_exists(lighting_darkness_surface)){
					lighting_darkness_surface = surface_create(_surface_width_scaled,_surface_height_scaled);
					lighting_darkness_surface_texture = surface_get_texture(lighting_darkness_surface);
				}
			#endregion
			
			#region Bloom Surface
				//Target Bloom Surface
				surface_set_target(lighting_bloom_surface);
			
				//Bloom is Enabled
				if(lighting_bloom_enabled){
					//Setup Bloom Shader
					shader_set(sh_bloom);
					shader_set_uniform_f(lighting_bloom_shader_uniform_intensity, lighting_bloom_intensity * filter_setting[CameraFilter.bloom]); //0 = off, 1 = a bit, 80 = extremely intense
					shader_set_uniform_f(lighting_bloom_shader_uniform_blur_size, lighting_bloom_blur_size);// usually something like 1/512 (0.001)

					//Draw Application Surface
					draw_surface(application_surface, 0, 0);
					
					//Reset Shader
					shader_reset();
				}
				else{
					//Draw Application Surface Normally
					draw_surface(application_surface, 0, 0);
				}
				
				//Stop Targeting Bloom Surface
				surface_reset_target();
			#endregion
		
			//Get Camera Data
			var _camera_zoom_resultat_inverse,_camera_start_x,_camera_start_y;
			with(o_camera){
				_camera_zoom_resultat_inverse = (1/zoom_resultant)*_lighting_scale;
				_camera_start_x = start_x;
				_camera_start_y = start_y;
			}
			
			//Setup Scale Data
			var _gui_scale,_position_scale_factor;
			_gui_scale = o_ui.gui_scale;
			_position_scale_factor = _camera_zoom_resultat_inverse * _gui_scale;
		
			#region Lighting Lights Surface
				//Target Lighting Surface
				surface_set_target(lighting_lights_surface);
		
				//View:		- if there's many lights, add some code to check if the light would be drawn to the view
				//			- if the view size is different from the view port you maybe need to change the drawing scale
						
				//Brightness:	- _light_intensity controls the brightness of all lights
				//			- if you want to control the brightness of each individual light, there's two ways:
				//			- for static brightness, just make their colour darker in the room editor
				//			- for dynamic changes: change image_alpha
					
				//Clear Surface and Set GPU Blendmode
				draw_clear(c_black);
				gpu_set_blendmode(bm_add);
	
				#region Draw Lights
					//Set Light Intensity
					var _light_intensity;
					_light_intensity = lighting_light_intensity;
			
					var _x,_y;
					with(o_light_parent){
						if(!camera_visible)
							continue;
						
						if(is_darkness)
							continue;
						
						//Calculate Position
						_x = (x - _camera_start_x) * _position_scale_factor;
						_y = (y - _camera_start_y) * _position_scale_factor;
						
						//Draw Light
						draw_sprite_ext(sprite_index, image_index, _x, _y, image_xscale*_position_scale_factor, image_yscale*_position_scale_factor, image_angle, image_blend, image_alpha * _light_intensity * light_intensity);
					}
				#endregion
	
				//Reset GPU
				gpu_set_blendmode(bm_normal);
			
				//Stop Targeting Lighting Surface
				surface_reset_target();
			#endregion
			
			#region Lighting Darkness Surface
				//Target Lighting Surface
				surface_set_target(lighting_darkness_surface);
		
				//View:		- if there's many lights, add some code to check if the light would be drawn to the view
				//			- if the view size is different from the view port you maybe need to change the drawing scale
						
				//Brightness:	- _light_intensity controls the brightness of all lights
				//			- if you want to control the brightness of each individual light, there's two ways:
				//			- for static brightness, just make their colour darker in the room editor
				//			- for dynamic changes: change image_alpha
					
				//Clear Surface and Set GPU Blendmode
				draw_clear(c_black);
				gpu_set_blendmode(bm_max);
	
				#region Draw Lights
					//Set Light Intensity
					var _light_intensity;
					_light_intensity = lighting_darkness_intensity;
			
					var _x,_y;
					with(o_light_parent){
						if(!camera_visible)
							continue;
							
						if(!is_darkness)
							continue;
						
						//Calculate Position
						_x = (x - _camera_start_x) * _position_scale_factor;
						_y = (y - _camera_start_y) * _position_scale_factor;
						
						//Draw Light
						draw_sprite_ext(sprite_index, image_index, _x, _y, image_xscale*_position_scale_factor, image_yscale*_position_scale_factor, image_angle, image_blend, image_alpha * _light_intensity * light_intensity);
					}
				#endregion
	
				//Reset GPU
				gpu_set_blendmode(bm_normal);
			
				//Stop Targeting Lighting Surface
				surface_reset_target();
			#endregion

			#region Update Application Surface with Lighting
				//Setup Lighting Shader
				shader_set(sh_lighting);
				
				//Shader Update
				if(lighting_shader_update){
					shader_set_uniform_f_array(lighting_shader_uniform_col, lighting_colour_mix);
					
					shader_set_uniform_f_array(lighting_shader_uniform_con_sat_brt, lighting_image_mix);
					
					
					lighting_shader_update = false;
				}
				
				texture_set_stage(lighting_shader_sampler_index_lights, lighting_lights_surface_texture);
				texture_set_stage(lighting_shader_sampler_index_darkness, lighting_darkness_surface_texture);
	
				//Update Application Surface
				if(surface_exists(application_surface)){
					surface_copy(application_surface,0,0,lighting_bloom_surface);
				}
				
				//Reset Target
				shader_reset();
			#endregion
		}
	#endregion
#endregion
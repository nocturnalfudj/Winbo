#region Filter Layer Update
	//TODO - Optimise this so it doesnt run every step
	//Apply
	camera_filter_settings_update_layers();
#endregion

//GameState Switch
switch(global.game_state){
	case GameState.menu:
	case GameState.play:
		camera_game_state_default();
	break;
	
	case GameState.start:
		camera_game_state_start();
	break;
	
	case GameState.stop:
		camera_game_state_stop();
	break;
	
	case GameState.os_paused:
		//Shader Updates Need to Be Triggered Again
		//(for some platforms, like mobile, graphics pipeline data is lost/reset on unfocus, and so best to just give things a refresh)
		lighting_shader_update = true;
		vignette_noise_shader_update = true;
		glitch_shader_update = true;
	break;
}

#region VFX
	#region Lighting
		if(lighting_enable){											
			//Intensity & Colour & Image Mix Update
			lighting_light_intensity = lerp_with_gap_close(lighting_light_intensity,lighting_light_intensity_target,lighting_light_intensity_lerpval,0.01,false);
			lighting_colour_mix_update();
			lighting_image_mix_update();
		}
	#endregion
	
	#region Vignette Noise
		if(vignette_noise_enable){
			//Update Colour & Settings
			vignette_noise_colour_update();
			vignette_noise_setting_update();
		}
	#endregion
	
	#region Glitch
		if(glitch_enable){			
			//Update Magnitude Transform Value
			with(glitch_magnitude){
				if(animating){
					transform_value_update(global.delta_time_factor,-1);
					other.glitch_shader_update = true;
				}
			}
			
			//Update Settings
			glitch_setting_update();
		}
	#endregion
#endregion
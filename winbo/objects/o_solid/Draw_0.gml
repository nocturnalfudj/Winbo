//Ignore if Not Visible
if(!camera_visible)
	exit;

//Only Operate In Normal Draw Event
if(o_director.depth_grid_draw_event_state != 1)
	exit;

#region Glitch Shader Begin
	//if(glitch_enable){
	//	var _glitch_magnitude;
	//	_glitch_magnitude = glitch_magnitude.current * glitch_setting_current[GlitchSetting.intensity];
		
	//	if(_glitch_magnitude > 0){
	//		// Activating the shader
	//		bktglitch_activate();

	//		// Setting the overall intensity of the effect
	//		if(true){		
	//			bktglitch_set_line_speed(			glitch_setting_current[GlitchSetting.line_speed]);		
	//			bktglitch_set_line_shift(			glitch_setting_current[GlitchSetting.line_shift]);
	//			bktglitch_set_line_resolution(		glitch_setting_current[GlitchSetting.line_resolution]);
	//			bktglitch_set_line_vertical_shift(	glitch_setting_current[GlitchSetting.line_vertical_shift]);
	//			bktglitch_set_line_drift(			glitch_setting_current[GlitchSetting.line_drift]);
	//			bktglitch_set_jumble_speed(			glitch_setting_current[GlitchSetting.jumble_speed]);
	//			bktglitch_set_jumble_shift(			glitch_setting_current[GlitchSetting.jumble_shift]);
	//			bktglitch_set_jumble_resolution(	glitch_setting_current[GlitchSetting.jumble_resolution]);
	//			bktglitch_set_jumbleness(			glitch_setting_current[GlitchSetting.jumbleness]);
	//			bktglitch_set_channel_dispersion(	glitch_setting_current[GlitchSetting.channel_dispersion]);
	//			bktglitch_set_channel_shift(		glitch_setting_current[GlitchSetting.channel_shift]);	
	//			bktglitch_set_noise_level(			glitch_setting_current[GlitchSetting.noise_level]);
	//			bktglitch_set_shakiness(			glitch_setting_current[GlitchSetting.shakiness]);	
	//			bktglitch_set_rng_seed(				glitch_setting_current[GlitchSetting.rng_seed]);
	//			bktglitch_set_intensity(			_glitch_magnitude);
	//			//bktglitch_set_time(				glitch_setting_target[GlitchSetting.time]);
	//			//bktglitch_set_resolution(			glitch_setting_target[GlitchSetting.resolution]);	
	//		}
	//	}
	//}
#endregion

draw_sprite_ext(sprite_current,sprite_current_frame,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	
if(o_master.dev_mode){
	draw_bounding_box(true);
}

//Reset Shader
shader_reset();
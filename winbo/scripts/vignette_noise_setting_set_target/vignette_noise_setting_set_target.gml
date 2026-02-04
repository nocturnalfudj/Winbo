function vignette_noise_setting_set_target(_inner_circle_size,_outter_circle_size,_noise_strength){
	var _setting;
	
	//Inner Circle Size
	_setting = VignetteNoiseSetting.inner_circle_size;
	vignette_noise_setting_setting_target[_setting] = _inner_circle_size;
	
	//Outter Circle Size
	_setting = VignetteNoiseSetting.outter_circle_size;
	vignette_noise_setting_setting_target[_setting] = _outter_circle_size;
	
	//Noise Strength
	_setting = VignetteNoiseSetting.noise_strength;
	vignette_noise_setting_setting_target[_setting] = _noise_strength;
	
	//Vignette Noise Shader Needs Updating
	vignette_noise_shader_update = true;
}
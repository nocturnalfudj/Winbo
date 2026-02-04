/// @function vignette_noise_setting_set_current_target
/// @summary Set target values for vignette noise animation.
/// @param _inner_circle_size Desired inner circle size.
/// @param _outter_circle_size Desired outer circle size.
/// @param _noise_strength Desired noise strength.
function vignette_noise_setting_set_current_target(_inner_circle_size,_outter_circle_size,_noise_strength){
	var _setting;
	
	//Inner Circle Size
	_setting = VignetteNoiseSetting.inner_circle_size;
	vignette_noise_setting_setting_current[_setting] = _inner_circle_size;
	vignette_noise_setting_setting_target[_setting]	= vignette_noise_setting_setting_current[_setting];
	
	//Outter Circle Size
	_setting = VignetteNoiseSetting.outter_circle_size;
	vignette_noise_setting_setting_current[_setting] = _outter_circle_size;
	vignette_noise_setting_setting_target[_setting]	= vignette_noise_setting_setting_current[_setting];
	
	//Noise Strength
	_setting = VignetteNoiseSetting.noise_strength;
	vignette_noise_setting_setting_current[_setting] = _noise_strength;
	vignette_noise_setting_setting_target[_setting]	= vignette_noise_setting_setting_current[_setting];
	
	//Vignette Noise Shader Needs Updating
	vignette_noise_shader_update = true;
}
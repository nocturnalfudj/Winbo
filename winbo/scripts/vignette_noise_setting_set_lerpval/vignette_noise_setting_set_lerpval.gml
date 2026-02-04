/// @function vignette_noise_setting_set_lerpval
/// @summary Update vignette noise settings with new lerp values.
/// @param _inner_circle_size Inner circle radius fraction.
/// @param _outter_circle_size Outer circle radius fraction.
/// @param _noise_strength Amount of noise to apply.
/// @returns {void}
function vignette_noise_setting_set_lerpval(_inner_circle_size,_outter_circle_size,_noise_strength){
	var _setting;
	
	//Inner Circle Size
	_setting = VignetteNoiseSetting.inner_circle_size;
	vignette_noise_setting_setting_lerpval[_setting] = _inner_circle_size;
	
	//Outter Circle Size
	_setting = VignetteNoiseSetting.outter_circle_size;
	vignette_noise_setting_setting_lerpval[_setting] = _outter_circle_size;
	
	//Noise Strength
	_setting = VignetteNoiseSetting.noise_strength;
	vignette_noise_setting_setting_lerpval[_setting] = _noise_strength;
	
	//Vignette Noise Shader Needs Updating
	vignette_noise_shader_update = true;
}
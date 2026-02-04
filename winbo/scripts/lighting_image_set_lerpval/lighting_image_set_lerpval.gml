/// @function lighting_image_set_lerpval
/// @summary Change colour grading parameters for the lighting image.
/// @param _contrast Contrast factor.
/// @param _saturation Saturation factor.
/// @param _brightness Brightness factor.
/// @param _pop_strength Pop strength amount.
/// @param _pop_threshold Pop threshold value.
/// @param _gamma Gamma correction value.
/// @returns {void}
function lighting_image_set_lerpval(_contrast,_saturation,_brightness,_pop_strength,_pop_threshold,_gamma){
	var _image;
	
	//Contrast
	_image = LightingImage.contrast;
	lighting_image_lerpval[_image]	= _contrast;
	
	//Saturation
	_image = LightingImage.saturation;
	lighting_image_lerpval[_image]	= _saturation;
	
	//Brightness
	_image = LightingImage.brightness;
	lighting_image_lerpval[_image]	= _brightness;
	
	//Pop Strength
	_image = LightingImage.pop_strength;
	lighting_image_lerpval[_image]	= _pop_strength;
	
	//Pop Threshold
	_image = LightingImage.pop_threshold;
	lighting_image_lerpval[_image]	= _pop_threshold;
	
	//Gamma
	_image = LightingImage.gamma;
	lighting_image_lerpval[_image]	= _gamma;
}
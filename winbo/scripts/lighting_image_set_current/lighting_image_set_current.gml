function lighting_image_set_current(_contrast,_saturation,_brightness,_pop_strength,_pop_threshold,_gamma){
	var _image;
	
	//Contrast
	_image = LightingImage.contrast;
	lighting_image_current[_image]	= _contrast;
	
	//Saturation
	_image = LightingImage.saturation;
	lighting_image_current[_image]	= _saturation;
	
	//Brightness
	_image = LightingImage.brightness;
	lighting_image_current[_image]	= _brightness;
	
	//Pop Strength
	_image = LightingImage.pop_strength;
	lighting_image_current[_image]	= _pop_strength;
	
	//Pop Threshold
	_image = LightingImage.pop_threshold;
	lighting_image_current[_image]	= _pop_threshold;
	
	//Gamma
	_image = LightingImage.gamma;
	lighting_image_current[_image]	= _gamma;
	
	//Lighting Shader Needs Updating
	lighting_shader_update = true;
}
function lighting_image_set_current_target(_contrast,_saturation,_brightness,_pop_strength,_pop_threshold,_gamma){
	var _image;
	
	//Contrast
	_image = LightingImage.contrast;
	lighting_image_current[_image]	= _contrast;
	lighting_image_target[_image]	= lighting_image_current[_image];
	
	//Saturation
	_image = LightingImage.saturation;
	lighting_image_current[_image]	= _saturation;
	lighting_image_target[_image]	= lighting_image_current[_image];
	
	//Brightness
	_image = LightingImage.brightness;
	lighting_image_current[_image]	= _brightness;
	lighting_image_target[_image]	= lighting_image_current[_image];
	
	//Pop Strength
	_image = LightingImage.pop_strength;
	lighting_image_current[_image]	= _pop_strength;
	lighting_image_target[_image]	= lighting_image_current[_image];
	
	//Pop Threshold
	_image = LightingImage.pop_threshold;
	lighting_image_current[_image]	= _pop_threshold;
	lighting_image_target[_image]	= lighting_image_current[_image];
	
	//Pop Threshold
	_image = LightingImage.pop_threshold;
	lighting_image_current[_image]	= _pop_threshold;
	lighting_image_target[_image]	= lighting_image_current[_image];
	
	//Gamma
	_image = LightingImage.gamma;
	lighting_image_current[_image]	= _gamma;
	lighting_image_target[_image]	= lighting_image_current[_image];
	
	//Lighting Shader Needs Updating
	lighting_shader_update = true;
}
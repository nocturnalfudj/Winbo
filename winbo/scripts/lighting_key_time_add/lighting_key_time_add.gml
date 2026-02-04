function lighting_key_time_add(_red, _green, _blue, _contrast, _saturation, _brightness, _pop_strength, _pop_threshold) {
	var _i;
	
	if(is_undefined(lighting_colour_key_time[0][0])){
		_i = 0;
	}else{
		_i = array_length(lighting_colour_key_time);
	}

	//Colour
	lighting_colour_key_time[_i][LightingColour.red]		= _red	/255;
	lighting_colour_key_time[_i][LightingColour.green]	= _green/255;
	lighting_colour_key_time[_i][LightingColour.blue]	= _blue	/255;

	//Settings
	lighting_image_key_time[_i][LightingImage.contrast]		= _contrast;
	lighting_image_key_time[_i][LightingImage.saturation]	= _saturation;
	lighting_image_key_time[_i][LightingImage.brightness]	= _brightness;
	lighting_image_key_time[_i][LightingImage.pop_strength]	= _pop_strength;
	lighting_image_key_time[_i][LightingImage.pop_threshold] = _pop_threshold;
	
	//Update Key Time Count
	key_time_count = array_length(lighting_colour_key_time);
}

function lighting_key_time_update(){
	//Calculate Key Time
	var _key_time;
	_key_time = 0;
	lighting_key_previous	= min(floor(_key_time * key_time_count), key_time_count -1);
	lighting_key_next		= (lighting_key_previous + 1) mod key_time_count;

	//Calculate Lerp Value
	var _lerp_value	= (_key_time - lighting_key_previous/key_time_count) * key_time_count;

	//Mix Colour Values
	lighting_colour_mix	=  [lerp(lighting_colour_key_time[lighting_key_previous][LightingColour.red],		lighting_colour_key_time[lighting_key_next][LightingColour.red],		_lerp_value),
							lerp(lighting_colour_key_time[lighting_key_previous][LightingColour.green],		lighting_colour_key_time[lighting_key_next][LightingColour.green],		_lerp_value),
							lerp(lighting_colour_key_time[lighting_key_previous][LightingColour.blue],		lighting_colour_key_time[lighting_key_next][LightingColour.blue],		_lerp_value)];
		
	//Mix Image Values
	lighting_image_mix	=  [lerp(lighting_image_key_time[lighting_key_previous][LightingImage.contrast],	lighting_image_key_time[lighting_key_next][LightingImage.contrast],		_lerp_value),
							lerp(lighting_image_key_time[lighting_key_previous][LightingImage.saturation],	lighting_image_key_time[lighting_key_next][LightingImage.saturation],	_lerp_value),
							lerp(lighting_image_key_time[lighting_key_previous][LightingImage.brightness],	lighting_image_key_time[lighting_key_next][LightingImage.brightness],	_lerp_value),
							lerp(lighting_image_key_time[lighting_key_previous][LightingImage.pop_strength],lighting_image_key_time[lighting_key_next][LightingImage.pop_strength],	_lerp_value),
							lerp(lighting_image_key_time[lighting_key_previous][LightingImage.pop_threshold],lighting_image_key_time[lighting_key_next][LightingImage.pop_threshold],_lerp_value),
							lerp(lighting_image_key_time[lighting_key_previous][LightingImage.gamma],		lighting_image_key_time[lighting_key_next][LightingImage.gamma],		_lerp_value)];
}
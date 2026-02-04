function vignette_noise_colour_set_target(_red,_green,_blue){
	var _colour;
	
	//Red
	_colour = VignetteNoiseColour.red;
	vignette_noise_colour_target[_colour] = _red;
	
	//Green
	_colour = VignetteNoiseColour.green;
	vignette_noise_colour_target[_colour] = _green;
	
	//Blue
	_colour = VignetteNoiseColour.blue;
	vignette_noise_colour_target[_colour] = _blue;
	
	//Vignette Noise Shader Needs Updating
	vignette_noise_shader_update = true;
}
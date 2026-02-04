function vignette_noise_colour_set_lerpval(_red,_green,_blue){
	var _colour;
	
	//Red
	_colour = VignetteNoiseColour.red;
	vignette_noise_colour_lerpval[_colour] = _red;
	
	//Green
	_colour = VignetteNoiseColour.green;
	vignette_noise_colour_lerpval[_colour] = _green;
	
	//Blue
	_colour = VignetteNoiseColour.blue;
	vignette_noise_colour_lerpval[_colour] = _blue;
}
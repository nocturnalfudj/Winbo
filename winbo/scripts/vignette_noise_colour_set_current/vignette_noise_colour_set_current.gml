/// @function vignette_noise_colour_set_current
/// @summary Immediately change current vignette noise colour values.
/// @param {real} _red New red component.
/// @param {real} _green New green component.
/// @param {real} _blue New blue component.
function vignette_noise_colour_set_current(_red,_green,_blue){
	var _colour;
	
	//Red
	_colour = VignetteNoiseColour.red;
	vignette_noise_colour_current[_colour] = _red;
	
	//Green
	_colour = VignetteNoiseColour.green;
	vignette_noise_colour_current[_colour] = _green;
	
	//Blue
	_colour = VignetteNoiseColour.blue;
	vignette_noise_colour_current[_colour] = _blue;
	
	//Vignette Noise Shader Needs Updating
	vignette_noise_shader_update = true;
}
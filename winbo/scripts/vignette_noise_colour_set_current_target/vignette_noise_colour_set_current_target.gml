/// @function vignette_noise_colour_set_current_target
/// @summary Immediately set current and target vignette colours.
/// @param _red Red component 0..1.
/// @param _green Green component 0..1.
/// @param _blue Blue component 0..1.
/// @returns {void}
function vignette_noise_colour_set_current_target(_red,_green,_blue){
	var _colour;
	
	//Red
	_colour = VignetteNoiseColour.red;
	vignette_noise_colour_current[_colour] = _red;
	vignette_noise_colour_target[_colour]	= vignette_noise_colour_current[_colour];
	
	//Green
	_colour = VignetteNoiseColour.green;
	vignette_noise_colour_current[_colour] = _green;
	vignette_noise_colour_target[_colour]	= vignette_noise_colour_current[_colour];
	
	//Blue
	_colour = VignetteNoiseColour.blue;
	vignette_noise_colour_current[_colour] = _blue;
	vignette_noise_colour_target[_colour]	= vignette_noise_colour_current[_colour];
	
	//Vignette Noise Shader Needs Updating
	vignette_noise_shader_update = true;
}
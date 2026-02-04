/// @function vignette_noise_colour_update
/// @summary Lerp current vignette colours toward their targets.
function vignette_noise_colour_update(){
	//Lerp to Targets
	var _current,_target,_lerpval;
	for(var _i=0;_i<VignetteNoiseColour.SIZE;_i++){
		_current = vignette_noise_colour_current[_i];
		_target = vignette_noise_colour_target[_i];
		_lerpval = vignette_noise_colour_lerpval[_i];
					
		if(_current != _target){
			vignette_noise_colour_current[_i] = lerp_with_gap_close(_current,_target,_lerpval,0.1);
				
			//Lighting Shader Needs Updating
			vignette_noise_shader_update = true;
		}
	}
}
function vignette_noise_setting_update(){
	//Lerp to Targets
	var _current,_target,_lerpval;
	for(var _i=0;_i<VignetteNoiseSetting.SIZE;_i++){
		_current = vignette_noise_setting_setting_current[_i];
		_target = vignette_noise_setting_setting_target[_i];
		_lerpval = vignette_noise_setting_setting_lerpval[_i];
					
		if(_current != _target){
			vignette_noise_setting_setting_current[_i] = lerp_with_gap_close(_current,_target,_lerpval,0.01);
				
			//Vignette Noise Shader Needs Updating
			vignette_noise_shader_update = true;
		}
	}
}
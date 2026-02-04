function glitch_setting_update(){
	//Lerp to Targets
	var _current,_target,_lerpval;
	for(var _i=0;_i<GlitchSetting.SIZE;_i++){
		_current = glitch_setting_current[_i];
		_target = glitch_setting_target[_i];
		_lerpval = glitch_setting_lerpval[_i];
					
		if(_current != _target){
			glitch_setting_current[_i] = lerp_with_gap_close(_current,_target,_lerpval,0.0001);
				
			//Glitch Shader Needs Updating
			glitch_shader_update = true;
		}
	}
}
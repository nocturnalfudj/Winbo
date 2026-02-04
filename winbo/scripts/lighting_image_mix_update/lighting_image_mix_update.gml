function lighting_image_mix_update(){	
	#region Image
		//Lerp to Targets
		var _current,_target,_lerpval;
		for(var _i=0;_i<LightingImage.SIZE;_i++){
			_current = lighting_image_current[_i];
			_target = lighting_image_target[_i];
			_lerpval = lighting_image_lerpval[_i];
					
			if(_current != _target){
				lighting_image_current[_i] = lerp_with_gap_close(_current,_target,_lerpval,0.001);
				
				//Lighting Shader Needs Updating
				lighting_shader_update = true;	
			}
		}
				
		//Mix Image Values
		lighting_image_mix[LightingImage.contrast]			= lighting_image_current[LightingImage.contrast];
		lighting_image_mix[LightingImage.saturation]		= lighting_image_current[LightingImage.saturation];
		lighting_image_mix[LightingImage.brightness]		= lighting_image_current[LightingImage.brightness];
		lighting_image_mix[LightingImage.pop_strength]		= lighting_image_current[LightingImage.pop_strength];
		lighting_image_mix[LightingImage.pop_threshold]		= lighting_image_current[LightingImage.pop_threshold];
		lighting_image_mix[LightingImage.gamma]				= lighting_image_current[LightingImage.gamma] * filter_setting[CameraFilter.gamma];
		
		
		//lighting_image_mix	=  [lighting_image_current[LightingImage.contrast],
		//						lighting_image_current[LightingImage.saturation],
		//						lighting_image_current[LightingImage.brightness],
		//						lighting_image_current[LightingImage.pop_strength],
		//						lighting_image_current[LightingImage.pop_threshold],
		//						lighting_image_current[LightingImage.gamma] * filter_setting[CameraFilter.gamma],
		//						];
	#endregion
}
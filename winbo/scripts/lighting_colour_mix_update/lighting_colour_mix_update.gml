function lighting_colour_mix_update(){
	#region Colour
		//Lerp to Targets
		var _current,_target,_lerpval;
		for(var _i=0;_i<LightingColour.SIZE;_i++){
			_current = lighting_colour_current[_i];
			_target = lighting_colour_target[_i];
			_lerpval = lighting_colour_lerpval[_i];
					
			if(_current != _target){
				lighting_colour_current[_i] = lerp_with_gap_close(_current,_target,_lerpval,0.001);
				
				//Lighting Shader Needs Updating
				lighting_shader_update = true;
			}
		}
				
		//Mix Colour Values
		lighting_colour_mix[LightingColour.red]		= lighting_colour_current[LightingColour.red];
		lighting_colour_mix[LightingColour.green]	= lighting_colour_current[LightingColour.green];
		lighting_colour_mix[LightingColour.blue]	= lighting_colour_current[LightingColour.blue];
		
		//lighting_colour_mix	=  [lighting_colour_current[LightingColour.red],
		//						lighting_colour_current[LightingColour.green],
		//						lighting_colour_current[LightingColour.blue]
		//						];
	#endregion
}
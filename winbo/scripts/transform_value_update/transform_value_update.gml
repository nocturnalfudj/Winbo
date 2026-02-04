/// @function transform_value_update
/// @summary Update a transform value with easing and recoil logic.
/// @param _time_increase Time delta to apply.
/// @param _transform_value Which transform value is being updated.
/// @returns {void}
function transform_value_update(_time_increase,_transform_value){
	//Ignore if Paused
	if(animating_pause)
		exit;
		
	//Target Reached
	if(time_current >= time_max){
		//Update Current Values
		time_current = time_max;
		current = target;
		animating = false;
										
		//Recoil
		if(recoil){
			start = current;
			target = rest;
			time_current = 0;
			time_max = recoil_time;
			curve_is_ease_function = recoil_curve_is_ease_function;
			curve = recoil_curve;
			recoil = false;
			animating = true;
			target_start_difference = target - start;
		}
	}
	//Target Not Yet Reached
	else{
		#region Curve
			if((curve != noone) && (time_current >= 0)){
				#region Ease Function
					if(curve_is_ease_function){
						//If Transform Value is Colour
						if(_transform_value == TransformValue.colour){
							var _curve_value;
							_curve_value = script_execute(curve,0,1,false,time_current,time_max);
							current = merge_color(start,target,_curve_value);
						}
						//Else If Not Colour
						else{
							current = script_execute(curve,start,target,false,time_current,time_max);
						}
					}
				#endregion
				
				#region Animation Curve
					else{
						var _time_position,_curve_value;
						_time_position = time_current/time_max;
						_curve_value = animcurve_channel_evaluate(curve,_time_position);
				
						//If Transform Value is Colour
						if(_transform_value == TransformValue.colour){
							current = merge_color(start,target,_curve_value);
						}
						//Else If Not Colour
						else{
							current = start + target_start_difference*_curve_value;
						}
					}
				#endregion
			}
			//If no Curve Current set to Start
			else{
				current = start;
			}
		#endregion
		
		//Clamp Alpha
		if(_transform_value == TransformValue.alpha){
			current = clamp(current,0,1);
		}
			
		//Increase Time Current
		time_current += _time_increase;
		if(time_current > time_max)
			time_current = time_max;
			
		//Still Animating
		animating = true;
	}
}
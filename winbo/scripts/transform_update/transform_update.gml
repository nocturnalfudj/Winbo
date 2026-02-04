/// @function transform_update
/// @summary Update all animated values in a transform.
/// @param _transform Transform struct being updated.
/// @returns {void} No return value.
function transform_update(_transform){
	with(_transform){
		//Default Animating to false
		var _transform_animating;
		_transform_animating = false;
				
		//Go Through Each Transform Value
		var _delta_time;
		_delta_time = global.delta_time_factor;
		for(var _i=0;_i<TransformValue.SIZE;_i++){
			with(value[_i]){
				//If TransformValue is currently Animating AND Not Paused
				if(animating && !animating_pause){
					transform_value_update(_delta_time,_i);
									
					if(animating){
						_transform_animating = true;
					}
				}
			}
		}
				
		//Set whether or not the Transform is Animating
		animating = _transform_animating;
	}
}
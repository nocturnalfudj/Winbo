/// @function transform_animate_stop
/// @summary Halt an in-progress transform animation.
/// @param _transform Transform struct to modify.
/// @param _transform_value Specific value enum within the transform.
/// @returns {void} No return value.
function transform_animate_stop(_transform,_transform_value) {
	with(_transform){
		var _animating_pass;
		_animating_pass = false;
			
		with(value[_transform_value]){
			target = current;
			time_max = time_current;
			target_start_difference = target - start;
			
			_animating_pass = animating;
		}
			
		if(!animating)
			animating = _animating_pass;
	}
}
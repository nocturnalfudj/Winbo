/// @function transform_recoil_no_cruve
/// @summary Reset a transform value instantly without easing.
/// @param _transform Transform struct to modify.
/// @param _transform_value Value enum within the transform.
/// @returns {void} No return value.
function transform_recoil_no_cruve(_transform,_transform_value) {
	with(_transform){
		var _animating_pass;
		_animating_pass = false;
		
		with(value[_transform_value]){
			if(current != rest)
				animating = true;
			
			current = rest;
			target = current;
			
			target_start_difference = target - start;
			
			_animating_pass = animating;
		}
		
		if(!animating)
			animating = _animating_pass;
	}
}
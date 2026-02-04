/// @function transform_value_recoil_no_curve
/// @summary Instantly reset a transform value without easing.
/// @param _transform_value The TransformValue struct to modify.
/// @returns {void}
function transform_value_recoil_no_curve(_transform_value) {
	with(_transform_value){
		if(current != rest)
			animating = true;
			
		current = rest;
		target = current;
		target_start_difference = target - start;
	}
}
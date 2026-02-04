/// @function transform_value_animate_stop
/// @summary Stop an in-progress transform value animation.
function transform_value_animate_stop(_transform_value) {
	with(_transform_value){
		target = current;
		time_max = time_current;
		target_start_difference = target - start;
	}
}
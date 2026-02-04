/// @function transform_value_animate_from_current_relative_to_rest
/// @summary Animate a transform value relative to its rest position.
/// @param _transform_value TransformValue struct being animated.
/// @param _target Amount to offset from rest.
/// @param _time_current Start time in seconds.
/// @param _time_max Duration of the animation.
/// @param _curve Interpolation curve.
/// @param _recoil Whether to recoil at the end.
/// @param _curve_is_ease_function Treat curve as an easing function.
function transform_value_animate_from_current_relative_to_rest(_transform_value,_target,_time_current,_time_max,_curve,_recoil,_curve_is_ease_function) {
	if(is_undefined(_recoil)){
		_recoil = false;
	}
	
	if(is_undefined(_curve_is_ease_function)){
		_curve_is_ease_function = true;
	}
			
	with(_transform_value){
		var _target_final;
		_target_final = rest + _target;
			
		start = current;
		target = _target_final;
		time_max = _time_max;
		recoil = _recoil;
		
		curve_is_ease_function = _curve_is_ease_function;
		if(_curve_is_ease_function)
			curve = _curve;
		else
			curve = animcurve_get_channel(_curve,0);
			
		if(target != current){
			time_current = _time_current;
			target_start_difference = target - start;
			animating = true;
		}
		else{
			target_start_difference = 0;
			time_current = _time_max;
		}
	}
}
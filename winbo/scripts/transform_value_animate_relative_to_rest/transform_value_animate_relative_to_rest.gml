/// @function transform_value_animate_relative_to_rest
/// @summary Animate a transform value relative to its rest value.
/// @param _transform_value Struct containing the animated value.
/// @param _target Target offset from rest.
/// @param _time_current Elapsed time at the start.
/// @param _time_max Duration of the animation.
/// @param _curve Easing curve or animation curve asset.
/// @param _recoil Should the value overshoot then return.
/// @param _curve_is_ease_function Does _curve reference an easing function.
function transform_value_animate_relative_to_rest(_transform_value,_target,_time_current,_time_max,_curve,_recoil,_curve_is_ease_function) {
	if(is_undefined(_recoil)){
		_recoil = false;
	}
	
	if(is_undefined(_curve_is_ease_function)){
		_curve_is_ease_function = true;
	}
			
	with(_transform_value){
		start = rest +_start;
		target = rest + _target;
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
			time_current = _time_max;
			target_start_difference = 0;
		}
	}
}
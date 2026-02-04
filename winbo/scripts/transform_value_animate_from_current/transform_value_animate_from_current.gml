function transform_value_animate_from_current(_transform_value,_target,_time_current,_time_max,_curve,_recoil,_curve_is_ease_function) {
	if(is_undefined(_recoil)){
		_recoil = false;
	}
	
	if(is_undefined(_curve_is_ease_function)){
		_curve_is_ease_function = true;
	}
			
	with(_transform_value){
		start = current;
		target = _target;
		time_max = _time_max;
		recoil = _recoil;
		
		curve_is_ease_function = _curve_is_ease_function;
		if(_curve_is_ease_function)
			curve = _curve;
		else
			curve = animcurve_get_channel(_curve,0);
			
		if(_target != current){
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
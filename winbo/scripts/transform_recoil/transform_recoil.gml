function transform_recoil(_transform,_transform_value,_time_current,_time_max,_curve,_curve_is_ease_function) {
	if(is_undefined(_curve_is_ease_function)){
		_curve_is_ease_function = true;
	}
	
	with(_transform){
		var _animating_pass;
		_animating_pass = false;
		
		with(value[_transform_value]){
			start = current;
			target = rest;
			time_max = _time_max;
			recoil = false;
			
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
			
			_animating_pass = animating;
		}
		
		if(!animating)
			animating = _animating_pass;
	}
}
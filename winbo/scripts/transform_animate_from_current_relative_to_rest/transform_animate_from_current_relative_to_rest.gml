function transform_animate_from_current_relative_to_rest(_transform,_transform_value,_target,_time_current,_time_max,_curve,_recoil,_curve_is_ease_function) {
	if(is_undefined(_recoil)){
		_recoil = false;
	}
	
	if(is_undefined(_curve_is_ease_function)){
		_curve_is_ease_function = true;
	}
		
	with(_transform){
		var _animating_pass;
		_animating_pass = false;
			
		with(value[_transform_value]){
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
				time_current = _time_max;
				target_start_difference = 0;
			}
			
			_animating_pass = animating;
		}
			
		if(!animating)
			animating = _animating_pass;
	}
}
function transform_value_set_recoil(_transform_value,_recoil_time,_recoil_curve,_curve_is_ease_function){
	if(is_undefined(_curve_is_ease_function)){
		_curve_is_ease_function = true;
	}
	
	with(_transform_value){
		recoil_time = _recoil_time;
		
		recoil_curve_is_ease_function = _curve_is_ease_function;
		if(_curve_is_ease_function)
			recoil_curve = _recoil_curve;
		else
			recoil_curve = animcurve_get_channel(_recoil_curve,0);
	}
}
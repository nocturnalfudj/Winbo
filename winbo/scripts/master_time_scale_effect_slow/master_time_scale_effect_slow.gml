function master_time_scale_effect_slow(_scale,_time_max){
	_scale ??= 0.25;
	_time_max ??= SECOND * 0.2;
	
	//Time Scale Effect
	with(o_master){				
		time_effect_scale = _scale;
		time_effect_scale_start = time_effect_scale;
		time_effect_scale_target = 1;
		time_effect_scale_ease = ease_cubic_in;
		time_effect_scale_time_max = _time_max;
		time_effect_scale_time_current = 0;
	}
}
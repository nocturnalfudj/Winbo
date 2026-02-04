function transform_value_set_time_max_factor(_transform_value,_time_max_factor){	
	with(_transform_value){
		var _time_max;
		_time_max = time_max * _time_max_factor;
		if(_time_max != time_max){
			if(time_current != time_max){
				var _time_current_percent;
				_time_current_percent = time_current/time_max;
				time_max = _time_max;
				time_current = _time_current_percent*time_max;
			}
			else{
				time_max = _time_max;
				time_current = _time_max;
			}
		}
	}
}
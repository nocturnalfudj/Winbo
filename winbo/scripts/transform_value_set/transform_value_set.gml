function transform_value_set(_transform_value,_value,_add_to_current) {
	with(_transform_value){
		if(_add_to_current){
			var _new_current;
			_new_current = current + _value;

			if(_new_current != current){
				animating = true;
					
				current = _new_current;
			}
		}
		else{
			if(_value != current){
				animating = true;
					
				current = _value;
			}
		}
		target = current;
		target_start_difference = 0;
		time_current = time_max;
	}
}
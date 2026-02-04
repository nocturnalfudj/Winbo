/// @function transform_set_time_max_factor
/// @summary Scale the duration of an animation by the given factor.
/// @param _transform Transform struct containing the value.
/// @param _transform_value Which value index to adjust.
/// @param _time_max_factor Multiplier applied to the current time_max.
function transform_set_time_max_factor(_transform,_transform_value,_time_max_factor){
	with(_transform){	
		with(value[_transform_value]){
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
}
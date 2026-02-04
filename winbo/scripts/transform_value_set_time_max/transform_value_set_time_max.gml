/// @function transform_value_set_time_max
/// @summary Change the total animation time for a transform value.
/// @param _transform_value Transform value struct being modified.
/// @param _time_max New maximum time for the animation.
function transform_value_set_time_max(_transform_value,_time_max){
	with(_transform_value){
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
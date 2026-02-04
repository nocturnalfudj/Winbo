/// @function lerp_with_gap_close
/// @summary Lerp one value toward another until within a gap threshold.
/// @param start                  Starting value
/// @param end                    Target value
/// @param lerp_val               Lerp factor (0-1)
/// @param gap                    Distance from target allowed before snapping
/// @param use_delta_time_scaled  Whether to scale interpolation by delta time
function lerp_with_gap_close(_x,_y,_lerp_val,_gap,use_delta_time_scaled) {
	if(_x != _y){
		if(use_delta_time_scaled == undefined)
			use_delta_time_scaled = false;

		var _delta_time;
		if(use_delta_time_scaled)
			_delta_time = global.delta_time_factor_scaled;
		else
			_delta_time = global.delta_time_factor;

		_lerp_val = _lerp_val*_delta_time;

		if((abs(_x-_y) > _gap) && (_lerp_val<1)){
			_x = lerp(_x,_y,_lerp_val);
			return _x;
		}
		else{
			return _y;
		}
	}
	else{
		return _x;
	}
}
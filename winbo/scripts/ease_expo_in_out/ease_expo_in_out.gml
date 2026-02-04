/// @function ease_expo_in_out
/// @summary Exponential ease-in/out used for smooth acceleration and deceleration.
/// @param {real} start Starting value.
/// @param {real} target Target value.
/// @param {bool} relativeTarget Treat target as a delta when true.
/// @param {real} timeCurrent Current time value.
/// @param {real} timeMax Total time of the interpolation.
function ease_expo_in_out(_start,_target,_relative,_time_current,_time_max) {
	if(!_relative)
		_target -= _start;

	_time_current /= _time_max * 0.5;

	if (_time_current < 1){
	    return _target * 0.5 * power(2, 10 * --_time_current) + _start;
	}

	return _target * 0.5 * (-power(2, -10 * --_time_current) + 2) + _start;
}
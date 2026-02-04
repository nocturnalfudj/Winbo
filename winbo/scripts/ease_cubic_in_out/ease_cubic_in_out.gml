/// @function ease_cubic_in_out
/// @summary Cubic ease-in-out interpolation.
/// @param {real} start Starting value.
/// @param {real} target Target end value.
/// @param {bool} relativeTarget Treat target as relative to start when true.
/// @param {real} timeCurrent Current time in the easing process.
/// @param {real} timeMax Total duration of the easing.
/// @returns {real} Interpolated value for the current time.
function ease_cubic_in_out(_start,_target,_relative,_time_current,_time_max) {
	if(!_relative)
		_target -= _start;

	_time_current /= _time_max * 0.5;

	if (_time_current < 1){
	   return _target * 0.5 * power(_time_current, 3) + _start;
	}

	return _target * 0.5 * (power(_time_current - 2, 3) + 2) + _start;
}
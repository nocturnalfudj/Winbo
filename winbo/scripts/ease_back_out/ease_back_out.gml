/// @function ease_back_out
/// @summary Ease out with overshoot at the end.
/// @param {real} start Starting value.
/// @param {real} target Target value.
/// @param {bool} relativeTarget Treat target as relative to start when true.
/// @param {real} timeCurrent Current time.
/// @param {real} timeMax Duration of the interpolation.
/// @returns {real} Interpolated value.
function ease_back_out(_start,_target,_relative,_time_current,_time_max) {
	if(!_relative)
		_target -= _start;

	var _s = 1.70158;

	_time_current = _time_current/_time_max - 1;
	return _target * (_time_current * _time_current * ((_s + 1) * _time_current + _s) + 1) + _start;
}
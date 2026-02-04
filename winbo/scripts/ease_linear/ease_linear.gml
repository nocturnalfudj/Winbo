/// @function ease_linear
/// @summary Linear interpolation between two values.
///@param {real} start
///@param {real} target
///@param {bool} relativeTarget
///@param {real} timeCurrent
///@param {real} timeMax
function ease_linear(_start,_target,_relative,_time_current,_time_max) {
	if(!_relative)
		_target -= _start;

	return _target * (_time_current / _time_max) + _start;
}
///@param {real} start
///@param {real} target
///@param {bool} relativeTarget
///@param {real} timeCurrent
///@param {real} timeMax
function ease_expo_in(_start,_target,_relative,_time_current,_time_max) {
	if(!_relative)
		_target -= _start;

	return _target * power(2, 10 * (_time_current / _time_max - 1)) + _start;
}
/// @function ease_back_in
/// @summary Ease function with a slight backwards start.
///@param {real} start
///@param {real} target
///@param {bool} relativeTarget
///@param {real} timeCurrent
///@param {real} timeMax
function ease_back_in(_start,_target,_relative,_time_current,_time_max) {
	if(!_relative)
		_target -= _start;

	var _s = 1.70158;

	_time_current /= _time_max;
	return _target * _time_current * _time_current * ((_s + 1) * _time_current - _s) + _start;
}
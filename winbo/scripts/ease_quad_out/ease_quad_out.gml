///@param {real} start
///@param {real} target
///@param {bool} relativeTarget
///@param {real} timeCurrent
///@param {real} timeMax
function ease_quad_out(_start,_target,_relative,_time_current,_time_max) {
	if(!_relative)
		_target -= _start;

	_time_current /= _time_max;
	return -_target * _time_current * (_time_current - 2) + _start;
}
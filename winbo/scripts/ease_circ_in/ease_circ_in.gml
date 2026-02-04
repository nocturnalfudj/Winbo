///@param {real} start
///@param {real} target
///@param {bool} relativeTarget
///@param {real} timeCurrent
///@param {real} timeMax
function ease_circ_in(_start,_target,_relative,_time_current,_time_max) {
	if(!_relative)
		_target -= _start;

	_time_current /= _time_max;
	return _target * (1 - sqrt(1 - _time_current * _time_current)) + _start;
}
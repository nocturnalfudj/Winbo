///@param {real} start
///@param {real} target
///@param {bool} relativeTarget
///@param {real} timeCurrent
///@param {real} timeMax
function ease_circ_out(_start,_target,_relative,_time_current,_time_max) {
	if(!_relative)
		_target -= _start;

	_time_current = _time_current / _time_max - 1;
	return _target * sqrt(1 - _time_current * _time_current) + _start;
}
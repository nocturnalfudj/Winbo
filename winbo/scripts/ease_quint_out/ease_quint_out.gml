///@param {real} start
///@param {real} target
///@param {bool} relativeTarget
///@param {real} timeCurrent
///@param {real} timeMax
function ease_quint_out(_start,_target,_relative,_time_current,_time_max) {
	if(!_relative)
		_target -= _start;

	return _target * (power(_time_current / _time_max - 1, 5) + 1) + _start;
}
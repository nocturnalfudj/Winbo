///@param {real} start
///@param {real} target
///@param {bool} relativeTarget
///@param {real} timeCurrent
///@param {real} timeMax
function ease_back_in_out(_start,_target,_relative,_time_current,_time_max) {
	if(!_relative)
		_target -= _start;

	var _s = 1.70158;

	_time_current = _time_current/_time_max*2

	if(_time_current < 1){
	    _s *= 1.525;
	    return _target * 0.5 * (_time_current * _time_current * ((_s + 1) * _time_current - _s)) + _start;
	}

	_time_current -= 2;
	_s *= 1.525

	return _target * 0.5 * (_time_current * _time_current * ((_s + 1) * _time_current + _s) + 2) + _start;
}
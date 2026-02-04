///@param {real} start
///@param {real} target
///@param {bool} relativeTarget
///@param {real} timeCurrent
///@param {real} timeMax
function ease_bounce_in_out(_start,_target,_relative,_time_current,_time_max) {
	if(!_relative)
		_target -= _start;

	if (_time_current < _time_max*0.5) {
	    return (ease_bounce_in(0, _target, _relative, _time_current*2, _time_max)*0.5 + _start);
	}

	return (ease_bounce_out(0, _target, _relative, _time_current*2 - _time_max, _time_max)*0.5 + _target*0.5 + _start);
}
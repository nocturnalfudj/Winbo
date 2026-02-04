///@param {real} start
///@param {real} target
///@param {bool} relativeTarget
///@param {real} timeCurrent
///@param {real} timeMax
function ease_bounce_out(_start,_target,_relative,_time_current,_time_max) {
	if(!_relative)
		_target -= _start;

	_time_current /= _time_max;

	if (_time_current < 1/2.75){
	    return _target * 7.5625 * _time_current * _time_current + _start;
	}
	else if(_time_current < 2/2.75){
	    _time_current -= 1.5/2.75;
	    return _target * (7.5625 * _time_current * _time_current + 0.75) + _start;
	}
	else if(_time_current < 2.5/2.75){
	    _time_current -= 2.25/2.75;
	    return _target * (7.5625 * _time_current * _time_current + 0.9375) + _start;
	}
	else{
	    _time_current -= 2.625/2.75;
	    return _target * (7.5625 * _time_current * _time_current + 0.984375) + _start;
	}
}
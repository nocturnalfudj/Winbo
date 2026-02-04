///@param {real} start
///@param {real} target
///@param {bool} relativeTarget
///@param {real} timeCurrent
///@param {real} timeMax
function ease_elastic_in_out(_start,_target,_relative,_time_current,_time_max) {
	if(!_relative)
		_target -= _start;

	var _s = 1.70158;
	var _p = 0;
	var _alpha = _target;

	if (_time_current == 0 || _alpha == 0){
	    return _start;
	}

	_time_current /= _time_max*0.5;

	if (_time_current == 2){
	    return _start+_target; 
	}

	if (_p == 0){
	    _p = _time_max * (0.3 * 1.5);
	}

	if (_alpha < abs(_target)) { 
	    _alpha = _target; 
	    _s = _p * 0.25; 
	}
	else{
	    _s = _p / (2 * pi) * arcsin (_target / _alpha);
	}

	if (_time_current < 1){
	    return -0.5 * (_alpha * power(2, 10 * (--_time_current)) * sin((_time_current * _time_max - _s) * (2 * pi) / _p)) + _start;
	}

	return _alpha * power(2, -10 * (--_time_current)) * sin((_time_current * _time_max - _s) * (2 * pi) / _p) * 0.5 + _target + _start;
}
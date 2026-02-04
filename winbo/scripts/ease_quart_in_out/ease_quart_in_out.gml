/// @function ease_quart_in_out
/// @summary Quartic easing in and out over a duration.
///@param {real} start
///@param {real} target
///@param {bool} relativeTarget
///@param {real} timeCurrent
///@param {real} timeMax
function ease_quart_in_out(_start,_target,_relative,_time_current,_time_max) {
	if(!_relative)
		_target -= _start;

	_time_current /= _time_max * 0.5;

	if (_time_current < 1){
		return _target * 0.5 * power(_time_current, 4) + _start;
	}

	return _target * -0.5 * (power(_time_current - 2, 4) - 2) + _start;
}
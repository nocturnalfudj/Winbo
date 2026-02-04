/// @function ease_quint_in
/// @summary Quintic easing that accelerates from zero velocity.
/// @param {real} start Starting value.
/// @param {real} target Target value.
/// @param {bool} relativeTarget Treat target as a delta when true.
/// @param {real} timeCurrent Current time value.
/// @param {real} timeMax Total time of the interpolation.
function ease_quint_in(_start,_target,_relative,_time_current,_time_max) {
	if(!_relative)
		_target -= _start;

	return _target * power(_time_current / _time_max, 5) + _start;
}
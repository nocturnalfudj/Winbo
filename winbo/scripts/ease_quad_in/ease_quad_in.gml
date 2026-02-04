/// @function ease_quad_in
/// @summary Quadratic easing with acceleration from zero.
/// @param {real} start Starting value.
/// @param {real} target Target value.
/// @param {bool} relativeTarget Treat target as a delta when true.
/// @param {real} timeCurrent Current time value.
/// @param {real} timeMax Total time of the interpolation.
function ease_quad_in(_start,_target,_relative,_time_current,_time_max) {
	if(!_relative)
		_target -= _start;

	_time_current /= _time_max;
	return _target * _time_current * _time_current + _start;
}
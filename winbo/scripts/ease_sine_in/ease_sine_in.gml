/// @function ease_sine_in
/// @summary Sine easing that starts slowly and speeds up.
/// @param {real} start Starting value.
/// @param {real} target Target value.
/// @param {bool} relativeTarget Treat target as a delta when true.
/// @param {real} timeCurrent Current time value.
/// @param {real} timeMax Total time of the interpolation.
function ease_sine_in(_start,_target,_relative,_time_current,_time_max) {
	if(!_relative)
		_target -= _start;

	return _target * (1 - cos(_time_current / _time_max * (pi / 2))) + _start;
}
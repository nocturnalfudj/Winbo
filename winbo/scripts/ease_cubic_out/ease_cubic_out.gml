/// @function ease_cubic_out
/// @summary Cubic easing that slows towards the end of the duration.
/// @param {real} start Starting value.
/// @param {real} target Target value.
/// @param {bool} relativeTarget Treat target as a delta when true.
/// @param {real} timeCurrent Current time value.
/// @param {real} timeMax Total time of the interpolation.
function ease_cubic_out(_start,_target,_relative,_time_current,_time_max) {
	if(!_relative)
		_target -= _start;

	return _target * (power(_time_current/_time_max - 1, 3) + 1) + _start;
}
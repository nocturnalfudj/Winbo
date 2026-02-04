/// @function ease_expo_out
/// @summary Exponential easing toward the target value.
/// @param {real} start Initial value.
/// @param {real} target Destination value.
/// @param {bool} relativeTarget Treat target as relative to start.
/// @param {real} timeCurrent Current time step.
/// @param {real} timeMax Total duration of the tween.
/// @returns {real} Interpolated value.
function ease_expo_out(_start,_target,_relative,_time_current,_time_max) {
	if(!_relative)
		_target -= _start;

	return _target * (-power(2, -10 * _time_current / _time_max) + 1) + _start;
}
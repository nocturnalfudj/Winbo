/// @function ease_bounce_in
/// @summary Bounce easing that overshoots and settles to the target.
/// @param {real} start Starting value.
/// @param {real} target Target value.
/// @param {bool} relativeTarget Treat target relative to start when true.
/// @param {real} timeCurrent Current time.
/// @param {real} timeMax Total duration of the easing.
/// @returns {real} Interpolated value.
function ease_bounce_in(_start,_target,_relative,_time_current,_time_max) {
	if(!_relative)
		_target -= _start;

	return _target - ease_outBounce(0,_target,_relative,_time_max - _time_current, _time_max) + _start
}
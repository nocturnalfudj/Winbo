/// @function wave_ags
/// @summary Simple sine wave helper used for animations.
/// @param _min   Minimum returned value.
/// @param _max   Maximum returned value.
/// @param _speed Cycles per second.
/// @param _time_current Current time value.
/// @returns {real} Oscillating result between min and max.
function wave_ags(_min,_max,_speed,_time_current){
	return _min + (1 + sin(2 * pi * _time_current * _speed)) * ((_max-_min)/2);
}
/// @function angle_clamp_around
/// @summary Clamp an angle around a center angle by a max deviation.
/// @param _angle Angle to clamp (degrees).
/// @param _center Center angle to clamp around (degrees).
/// @param _max_deviation Maximum allowed deviation from center (degrees).
/// @returns {real} Clamped angle in degrees.
function angle_clamp_around(_angle, _center, _max_deviation){
	_max_deviation = abs(_max_deviation);
	var _diff = angle_difference(_angle, _center);
	_diff = clamp(_diff, -_max_deviation, _max_deviation);
	return _center + _diff;
}

/// @function camera_shake
/// @summary Legacy function - creates camera shake using new system
/// @param _time Duration in seconds
/// @param _magnitude Base magnitude
/// @param [_speed] Speed multiplier (default: 1.0)
/// @param [_scale] Scale multiplier (default: 1.0)
/// @param [_horizontal_only] Only shake horizontally (default: false)
/// @param [_vertical_only] Only shake vertically (default: false)
/// @param [_rotation] Enable rotation shake (default: false)
/// @param [_rotation_magnitude] Rotation magnitude (default: 1.0)
/// @param [_ease_function] Easing function (default: noone)
/// @param [_toggle_mode] Toggle mode (default: false)
/// @param [_override_weaker] Override weaker shake (default: false)
function camera_shake(_time, _magnitude, _speed = 1.0, _scale = 1.0, _horizontal_only = false, _vertical_only = false, _rotation = false, _rotation_magnitude = 1.0, _ease_function = noone, _toggle_mode = false, _override_weaker = false) {
    // Use new system with default label
    return camera_shake_add(_time, _magnitude, _speed, _scale, _horizontal_only, _vertical_only, _rotation, _rotation_magnitude, _ease_function, _toggle_mode, "legacy");
}
/// @function camera_shake_add
/// @summary Legacy wrapper - Add a shake to the camera using new shake system
/// @param _duration Duration in seconds
/// @param _magnitude Base magnitude
/// @param [_speed] Speed multiplier (default: 1.0)
/// @param [_scale] Scale multiplier (default: 1.0)
/// @param [_horizontal_only] Only shake horizontally (default: false)
/// @param [_vertical_only] Only shake vertically (default: false)
/// @param [_rotation_enabled] Enable rotation shake (default: false)
/// @param [_rotation_magnitude] Rotation magnitude (default: 1.0)
/// @param [_ease_function] Easing function (default: noone)
/// @param [_toggle_mode] Toggle mode (default: false)
/// @param [_impulse_frequency] Impulses per second (default: 30.0)
/// @param [_spring] Spring constant 0-1 (default: 0.5)
/// @returns {real} Shake ID for later reference
function camera_shake_add(_duration, _magnitude, _speed = 1.0, _scale = 1.0, _horizontal_only = false, _vertical_only = false, _rotation_enabled = false, _rotation_magnitude = 1.0, _ease_function = noone, _toggle_mode = false, _impulse_frequency = 30.0, _spring = 0.5) {
    with(o_camera) {
        return shake_add(_duration, _magnitude, _speed, _scale, _horizontal_only, _vertical_only, _rotation_enabled, _rotation_magnitude, _ease_function, _toggle_mode, _impulse_frequency, _spring);
    }
    
    return -1; // Failed to add shake
}
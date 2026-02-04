/// @function shake_add
/// @summary Add a shake to the calling instance
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
function shake_add(_duration, _magnitude, _speed = 1.0, _scale = 1.0, _horizontal_only = false, _vertical_only = false, _rotation_enabled = false, _rotation_magnitude = 1.0, _ease_function = noone, _toggle_mode = false, _impulse_frequency = 30.0, _spring = 0.5) {
    // Validate essential parameters
    if(!is_real(_duration) || _duration < 0) {
        _duration = 1.0;
    }
    if(!is_real(_magnitude) || _magnitude < 0) {
        _magnitude = 1.0;
    }
    if(!is_real(_speed) || _speed <= 0) {
        _speed = 1.0;
    }
    if(!is_real(_scale) || _scale <= 0) {
        _scale = 1.0;
    }
    if(!is_real(_rotation_magnitude) || _rotation_magnitude < 0) {
        _rotation_magnitude = 1.0;
    }
    if(!is_real(_impulse_frequency) || _impulse_frequency < 0) {
        _impulse_frequency = 30.0;
    }
    if(!is_real(_spring) || _spring < 0 || _spring > 1) {
        _spring = 0.5;
    }
    
    // Create new shake struct
    var _shake = {
        shake_id: shake_id_counter++,
        label: "shake",
        
        // Timing
        time_total: _duration,
        time_current: 0,
        toggle_mode: _toggle_mode,
        
        // Properties
        magnitude: _magnitude,
        speed: _speed,
        scale: _scale,
        spring: _spring,
        ease_function: _ease_function,
        
        // Impulse control
        impulse_frequency: _impulse_frequency,
        impulse_timer: _impulse_frequency > 0 ? (1.0 / _impulse_frequency) : 0, // Start with first impulse ready
        impulse_interval: _impulse_frequency > 0 ? (1.0 / _impulse_frequency) : 0, // Seconds between impulses
        
        // Position shake
        current_x: 0,
        current_y: 0,
        velocity_x: 0,
        velocity_y: 0,
        horizontal_only: _horizontal_only,
        vertical_only: _vertical_only,
        rotation_only: false,
        
        // Rotation shake
        rotation_enabled: _rotation_enabled,
        rotation_magnitude: _rotation_magnitude,
        rotation_current: 0,
        rotation_velocity: 0
    };
    
    // Add to shake list
    shake_list[shake_count] = _shake;
    shake_count++;
    
    return _shake.shake_id;
} 
/// @function shake_system_update
/// @summary Update all active shakes and apply their effects
function shake_system_update() {
    if(shake_count <= 0) {
        // No active shakes, apply settling to combined shake
        shake_system_settle();
        return;
    }
    
    // Get delta time using existing system
    var _delta_time;
    if(shake_time_scale_enable) {
        _delta_time = global.delta_time * global.delta_time_factor_scaled / global.delta_time_factor;
    } else {
        _delta_time = global.delta_time;
    }
    
    // Variables for combining shake effects
    var _combined_x = 0;
    var _combined_y = 0;
    var _combined_rotation = 0;
    
    // Process each active shake
    for(var _i = shake_count - 1; _i >= 0; _i--) {
        var _shake = shake_list[_i];
        

        
        //------------------------------
        // 1. Update timers
        //------------------------------
        _shake.time_current += _delta_time;
        _shake.impulse_timer -= _delta_time;
        
        //------------------------------
        // 2. Spawn a random impulse if timer elapsed
        //------------------------------
        if(_shake.impulse_interval > 0 && _shake.impulse_timer <= 0) {
            // Reset timer (support catching up if very small dt)
            while(_shake.impulse_timer <= 0) {
                _shake.impulse_timer += _shake.impulse_interval;
            }
            
            // Smart impulse direction - bias toward center if shake is too far out
            var _max_drift = _shake.magnitude * _shake.scale * 0.4; // 40% of max allowed
            var _current_dist = sqrt(_shake.current_x * _shake.current_x + _shake.current_y * _shake.current_y);
            var _bias_toward_center = _current_dist > _max_drift;
            
            var _dir_x, _dir_y;
            if(_shake.horizontal_only) {
                if(_bias_toward_center) {
                    _dir_x = _shake.current_x > 0 ? -1 : 1; // Push toward center
                }
                else {
                    _dir_x = choose(-1,1);
                }
                _dir_y = 0;
            }
            else if(_shake.vertical_only) {
                _dir_x = 0;
                if(_bias_toward_center) {
                    _dir_y = _shake.current_y > 0 ? -1 : 1; // Push toward center
                }
                else {
                    _dir_y = choose(-1,1);
                }
            }
            else {
                if(_bias_toward_center) {
                    // Bias impulse toward center (opposite of current position)
                    var _center_angle = point_direction(_shake.current_x, _shake.current_y, 0, 0);
                    var _random_spread = 15; // Very tight spread for much stronger center bias
                    var _ang = _center_angle + random_range(-_random_spread/2, _random_spread/2);
                    _dir_x = dcos(_ang);
                    _dir_y = dsin(_ang);
                }
                else {
                    // Normal random direction
                    var _ang = random(360);
                    _dir_x = dcos(_ang);
                    _dir_y = dsin(_ang);
                }
            }
            
            var _impulse_mag = _shake.magnitude * _shake.scale * shake_physics_impulse_factor;
            _shake.velocity_x += _dir_x * _impulse_mag;
            _shake.velocity_y += _dir_y * _impulse_mag;
            
            // Rotation impulse (optional)
            if(_shake.rotation_enabled) {
                var _rot_dir = choose(-1,1);
                var _rot_impulse = _shake.rotation_magnitude * 2.0 * shake_physics_impulse_factor;
                _shake.rotation_velocity += _rot_dir * _rot_impulse;
            }
        }
        
        //------------------------------
        // 3. Physics integration (spring + damping)
        //------------------------------
        var _spring = clamp(_shake.spring, 0, 1);
        var _damping = shake_physics_damping;
        
        // Spring force back to origin (Hooke)
        var _acc_x = -_shake.current_x * _spring;
        var _acc_y = -_shake.current_y * _spring;
        
        _shake.velocity_x += _acc_x * _delta_time;
        _shake.velocity_y += _acc_y * _delta_time;
        
        // Damping (exponential decay)
        var _damp_factor = power(_damping, _delta_time * SECOND);
        _shake.velocity_x *= _damp_factor;
        _shake.velocity_y *= _damp_factor;
        
        // Integrate position
        _shake.current_x += _shake.velocity_x * _delta_time;
        _shake.current_y += _shake.velocity_y * _delta_time;
        
        // Rotation physics (if enabled)
        if(_shake.rotation_enabled) {
            var _rot_acc = -_shake.rotation_current * _spring;
            _shake.rotation_velocity += _rot_acc * _delta_time;
            _shake.rotation_velocity *= _damp_factor;
            _shake.rotation_current += _shake.rotation_velocity * _delta_time;
        }
        
        //------------------------------
        // 4. Fade-out & lifetime
        //------------------------------
        var _fade = 1.0;
        if(!_shake.toggle_mode) {
            _fade = max(0, 1 - (_shake.time_current / _shake.time_total));
            if(_fade == 0) {
                // Finished – remove and continue loop
                array_delete(shake_list, _i, 1);
                shake_count--;
                continue;
            }
        }
        
        // Clamp displacement to avoid extreme jumps
        var _max_offset = _shake.magnitude * _shake.scale * shake_physics_max_offset_factor;
        var _len_sq = _shake.current_x * _shake.current_x + _shake.current_y * _shake.current_y;
        if(_len_sq > _max_offset * _max_offset) {
            var _len = sqrt(_len_sq);
            _shake.current_x = _shake.current_x / _len * _max_offset;
            _shake.current_y = _shake.current_y / _len * _max_offset;
        }
        
        // Apply fade
        var _fx = _shake.current_x * _fade;
        var _fy = _shake.current_y * _fade;
        var _frot = _shake.rotation_current * _fade;
        
        // Combine contribution
        _combined_x += _fx;
        _combined_y += _fy;
        _combined_rotation += _frot;
    }
    

    
    // Apply to instance
    shake_combined_x = _combined_x;
    shake_combined_y = _combined_y;
    shake_combined_rotation = _combined_rotation;
    
    // Apply results based on configuration
    if(shake_use_transform) {
        shake_apply_to_transform();
    } else {
        shake_apply_to_instance();
    }
}
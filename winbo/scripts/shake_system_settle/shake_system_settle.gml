/// @function shake_system_settle
/// @summary Settle the combined shake towards zero when no shakes are active
function shake_system_settle() {
    // Get delta time for smooth settling
    var _delta_time = global.delta_time;
    
    // Use exponential decay for smooth settling
    var _settle_factor = power(shake_physics_settle_damping, _delta_time * SECOND);
    
    // Settle combined position
    shake_combined_x *= _settle_factor;
    shake_combined_y *= _settle_factor;
    
    // Settle combined rotation
    shake_combined_rotation *= _settle_factor;
    
    // Snap to zero if very small
    if(abs(shake_combined_x) < 0.5 && abs(shake_combined_y) < 0.5 && abs(shake_combined_rotation) < 0.02) {
        shake_combined_x = 0;
        shake_combined_y = 0;
        shake_combined_rotation = 0;
    }
    
    // Apply results based on configuration
    if(shake_use_transform) {
        shake_apply_to_transform();
    } else {
        shake_apply_to_instance();
    }
} 
/// @function debug_camera_shake_emergency_clear
/// @summary Emergency function to clear all shakes and reset the shake system
function debug_camera_shake_emergency_clear() {
    sdm("=== EMERGENCY CAMERA SHAKE CLEAR ===");
    
    if(!instance_exists(o_camera)) {
        sdm("ERROR: o_camera does not exist!");
        return;
    }
    
    with(o_camera) {
        sdm("Before clear - Active shakes: " + string(shake_count));
        
        // Clear all shakes
        camera_shake_clear_all();
        
        // Reinitialize the system to ensure clean state
        shake_system_create();
        
        // Reset transform to zero to clear any stuck shake values
        var _transform = transform[TransformType.relative];
        transform_set(_transform, TransformValue.x, 0, false);
        transform_set(_transform, TransformValue.y, 0, false);
        transform_set(_transform, TransformValue.angle, 0, false);
        
        sdm("After clear - Active shakes: " + string(shake_count));
    }
    
    sdm("=== EMERGENCY CLEAR COMPLETE ===");
} 
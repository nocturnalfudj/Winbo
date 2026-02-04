/// @function shake_system_create
/// @summary Initialize the shake system for any instance
function shake_system_create() {
    // Shake management
    shake_list = [];
    shake_count = 0;
    shake_id_counter = 0;
    
    // Combined shake output (sum of all active shakes)
    shake_combined_x = 0;
    shake_combined_y = 0;
    shake_combined_rotation = 0;
    
    // Configuration (set by instance after calling this)
    shake_use_transform = false;  // Default to direct x/y application
    shake_target_transform = TransformType.relative;
    shake_target_transform_reference = noone;
    
    // Physics settings (same proven values from camera shake)
    shake_physics_impulse_factor = 0.15;      // How strong impulses are applied
    shake_physics_damping = 0.85;             // Velocity damping (momentum retention)
    shake_physics_max_offset_factor = 1.2;    // Maximum offset multiplier  
    shake_physics_settle_damping = 0.75;      // Velocity damping when settling
    
    // Time scale settings
    shake_time_scale_enable = true;
    
    // Original position storage (for direct instance application)
    shake_original_x = x;
    shake_original_y = y;
    shake_original_angle = image_angle;
} 
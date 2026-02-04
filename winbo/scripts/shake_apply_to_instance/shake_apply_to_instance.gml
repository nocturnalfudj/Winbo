/// @function shake_apply_to_instance
/// @summary Apply shake values directly to instance variables
function shake_apply_to_instance() {
    
    if(shake_count <= 0) {
        // No active shakes - restore original values
        x = shake_original_x;
        y = shake_original_y;
        image_angle = shake_original_angle;
        return;
    }
    
    // Apply shake offset to original values
    x = shake_original_x + shake_combined_x;
    y = shake_original_y + shake_combined_y;
    image_angle = shake_original_angle + shake_combined_rotation;
} 
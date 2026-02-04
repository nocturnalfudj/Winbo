/// @function shake_emergency_clear
/// @summary Emergency function to clear all shakes and reset system
function shake_emergency_clear() {
    // Clear all shakes
    shake_clear_all();
    
    // Reset combined values
    shake_combined_x = 0;
    shake_combined_y = 0;
    shake_combined_rotation = 0;
    
    // Apply zero values to clear any stuck state
    if(shake_use_transform) {
        shake_apply_to_transform();
    } else {
        shake_apply_to_instance();
    }
} 
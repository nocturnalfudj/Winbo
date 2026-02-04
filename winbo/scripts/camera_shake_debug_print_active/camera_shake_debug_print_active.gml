/// @function camera_shake_debug_print_active
/// @summary Debug function to print all currently active shakes
function camera_shake_debug_print_active() {
    with(o_camera) {
        // SDM("=== ACTIVE SHAKES DEBUG ===");
        // SDM("Total active shakes: " + string(shake_count));
        for(var _i = 0; _i < shake_count; _i++) {
            var _shake = shake_list[_i];
            // SDM("Shake " + string(_i) + ": " + _shake.label + 
            //     " | ID: " + string(_shake.shake_id) + 
            //     " | Toggle: " + string(_shake.toggle_mode) + 
            //     " | H-Only: " + string(_shake.horizontal_only) + 
            //     " | V-Only: " + string(_shake.vertical_only) + 
            //     " | Rotation: " + string(_shake.rotation_enabled));
        }
        // SDM("=== END DEBUG ===");
    }
} 
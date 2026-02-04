/// @function camera_shake_clear_all
/// @summary Remove all active shakes
function camera_shake_clear_all() {
    with(o_camera) {
        shake_list = [];
        shake_count = 0;
        shake_combined_x = 0;
        shake_combined_y = 0;
        shake_combined_rotation = 0;
    }
} 
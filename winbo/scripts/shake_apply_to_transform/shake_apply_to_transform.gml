/// @function shake_apply_to_transform
/// @summary Apply shake values to the configured transform
function shake_apply_to_transform() {
    if(shake_target_transform_reference == noone) {
        return;
    }
    
    if(shake_count <= 0) {
        // No active shakes - set transform to zero immediately (no lerp back)
        transform_set(shake_target_transform_reference, TransformValue.x, 0, false);
        transform_set(shake_target_transform_reference, TransformValue.y, 0, false);
        transform_set(shake_target_transform_reference, TransformValue.angle, 0, false);
        return;
    }
    
    // Apply the combined shake values directly - no lerping
    // The shake physics system handles the natural decay to zero
    transform_set(shake_target_transform_reference, TransformValue.x, shake_combined_x, false);
    transform_set(shake_target_transform_reference, TransformValue.y, shake_combined_y, false);
    transform_set(shake_target_transform_reference, TransformValue.angle, shake_combined_rotation, false);
} 
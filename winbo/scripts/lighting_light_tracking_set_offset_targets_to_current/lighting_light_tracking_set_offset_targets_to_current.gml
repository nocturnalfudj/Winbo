/// @function lighting_light_tracking_set_offset_targets_to_current
/// @summary Copy current light tracking offsets into their targets.
function lighting_light_tracking_set_offset_targets_to_current(){
	//Targets
	offset_x_target = offset_x;
	offset_y_target = offset_y;
	offset_xscale_target = offset_xscale;
	offset_yscale_target = offset_yscale;
	offset_alpha_target = offset_alpha;
	image_blend_target = image_blend;
}
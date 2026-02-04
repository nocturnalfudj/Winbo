/// @function status_effect_end_fire
/// @summary Restore lighting values when a fire effect ends.
/// @returns {void} No return value.
function status_effect_end_fire(){
	#region Lighting
		with(tracking_light){
			offset_xscale_target	= other.tracking_light_pre_fire_scale_x;
			offset_yscale_target	= other.tracking_light_pre_fire_scale_y;
			image_blend_target		= other.tracking_light_pre_fire_colour;
			offset_alpha_target		= other.tracking_light_pre_fire_alpha;
		}
	#endregion
}
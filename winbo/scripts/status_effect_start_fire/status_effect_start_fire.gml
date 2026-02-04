/// @function status_effect_start_fire
/// @summary Initialise counters and visuals when fire begins.
/// @returns {void} No return value.
function status_effect_start_fire(){
	//Setup Fire Damage Countdown
	status_effect_fire_damage_countdown = 0;
	status_effect_fire_damage_countdown_max = SECOND * 0.2;
	
	//Setup Fire Trail Countdown
	status_effect_fire_trail_countdown_max = SECOND * 1;
	status_effect_fire_trail_countdown = status_effect_fire_trail_countdown_max;
	
	#region Lighting
		//If This is the First Fire Effect Starting
		//otherwise this is going to be set to the lighting settings that are currently being changed by an existing fire effect
		if(status_effect_active_count[StatusEffect.fire] == 1){
			tracking_light_pre_fire_colour = tracking_light.image_blend;
			tracking_light_pre_fire_alpha = tracking_light.offset_alpha;
			tracking_light_pre_fire_scale_x = tracking_light.offset_xscale;
			tracking_light_pre_fire_scale_y = tracking_light.offset_yscale;
		}
	#endregion
	
	//PFX
	pfx_trigger(pfx_fire_small_foreground);
	pfx_trigger(pfx_fire_small_background);
}
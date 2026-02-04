/// @function crumble_platform_state_crumble_idle
/// @summary Handle the idle state after crumbling
/// @returns {void}
function crumble_platform_state_crumble_idle(){
	// Clear any visual offsets during crumble idle
	visual_offset_x = 0;
	visual_offset_y = 0;
	
	// Wait for break animation to finish before doing anything else
	if(image.animate == true){
		// Break animation is still playing, wait for it to finish
		exit;
	}
	
	// Break animation finished - now fade out and start respawn countdown
	if(respawn_enable){
		// Idle timer
		crumble_idle_time -= global.delta_time_factor_scaled;
		
		// Fade to semi-transparent after break animation completes
		if(image_alpha > 0.2){
			image_alpha = 0.2;
		}
		
		// Idle complete
		if(crumble_idle_time <= 0){
			crumble_platform_state = CrumblePlatformState.respawn_countdown;
			respawn_countdown = respawn_countdown_max;
		}
	}
	// If respawn is disabled, stay in this state indefinitely
} 
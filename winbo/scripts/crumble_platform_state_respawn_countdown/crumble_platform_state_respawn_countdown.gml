/// @function crumble_platform_state_respawn_countdown
/// @summary Handle the countdown state before respawning
/// @returns {void}
function crumble_platform_state_respawn_countdown(){
	// Clear any visual offsets during respawn countdown
	visual_offset_x = 0;
	visual_offset_y = 0;
	
	// Only proceed with respawn countdown if respawn is enabled
	if(respawn_enable){
		// Respawn countdown timer
		respawn_countdown -= global.delta_time_factor_scaled;
		
		// Switch to idle animation and start flashing in last 30% of countdown
		if(respawn_countdown <= respawn_countdown_max * 0.3){
			// Switch back to idle animation when flashing starts (only once)
			if(image.sprite_current != sprite_idle){
				image_set_all(image, sprite_idle, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
			}
			
			// Show warning flash in last 30% of countdown
			var _flash_alpha = sin(current_time * 0.01) * 0.5 + 0.5;
			image_alpha = _flash_alpha * 0.3 + 0.2; // Flash between 0.2 and 0.5
			visible = true;
		}
		
		// Countdown complete
		if(respawn_countdown <= 0){
			crumble_platform_state = CrumblePlatformState.respawn_active;
		}
	} else {
		// If respawn gets disabled during countdown, go back to crumble_idle
		crumble_platform_state = CrumblePlatformState.crumble_idle;
		image_alpha = 0.2; // Reset to crumbled state
	}
} 
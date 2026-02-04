/// @function crumble_platform_state_crumble_countdown
/// @summary Handle the countdown state before crumbling
/// @returns {void}
function crumble_platform_state_crumble_countdown(){
	// Switch to break animation (non-looping, full opacity)
	if(sprite_current != sprite_break)
		image_set_all(image, sprite_break, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
	
	// Countdown timer
	crumble_countdown -= global.delta_time_factor_scaled;
	
	// Visual feedback (shaking gets more intense as countdown approaches zero)
	var _shake_intensity = (1 - (crumble_countdown / crumble_countdown_max)) * 6;
	if(_shake_intensity > 0){
		// Use visual offset variables instead of modifying actual position
		visual_offset_x = random_range(-_shake_intensity, _shake_intensity);
		visual_offset_y = random_range(-_shake_intensity, _shake_intensity);
	} else {
		visual_offset_x = 0;
		visual_offset_y = 0;
	}
	
	// Countdown complete
	if(crumble_countdown <= 0){
		crumble_platform_state = CrumblePlatformState.crumble_active;
		
		// Reset visual offsets when transitioning
		visual_offset_x = 0;
		visual_offset_y = 0;
	}
} 
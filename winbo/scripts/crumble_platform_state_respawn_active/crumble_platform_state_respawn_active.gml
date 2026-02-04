/// @function crumble_platform_state_respawn_active
/// @summary Handle the active respawning state (one step only)
/// @returns {void}
function crumble_platform_state_respawn_active(){
	// INSTANT TRANSITION - Execute effects and immediately move to next state
	
	// Safety check: Don't respawn if player is overlapping with original platform position
	if(place_meeting(origin_x, origin_y, o_player)){
		// Player is still inside platform area, stay in respawn countdown
		crumble_platform_state = CrumblePlatformState.respawn_countdown;
		respawn_countdown = respawn_countdown_max * 0.1; // Short delay before trying again
		return; // Exit early, don't respawn yet
	}
	
	// PHANTOM PLATFORM: Move platform back to original position
	phantom = false;
	x = origin_x;
	y = origin_y;
	
	// FORCE switch back to idle sprite (always reset to idle on respawn)
	image_set_all(image, sprite_idle, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
	
	// Reset visual state to fully visible
	image_alpha = 1.0;
	visible = true;
	
	// Optional: Play respawn sound
	// audio_sound_play(snd_platform_respawn, AudioChannel.sfx, false, 0);
	
	// Optional: Particle effects
	// Create respawn particles/dust
	
	// Reset trigger and return to idle
	crumble_trigger_active = false;
	crumble_platform_state = CrumblePlatformState.idle;
} 
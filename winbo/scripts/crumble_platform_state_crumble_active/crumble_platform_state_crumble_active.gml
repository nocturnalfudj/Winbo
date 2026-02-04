/// @function crumble_platform_state_crumble_active
/// @summary Handle the active crumbling state (one step only)
/// @returns {void}
function crumble_platform_state_crumble_active(){
	// INSTANT TRANSITION - Execute effects and immediately move to next state
	
	// Switch to break animation (non-looping, full opacity)
	if(sprite_current != sprite_break)
		image_set_all(image, sprite_break, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
	
	// Kick off any players who were grounded on this platform
	with(o_player){
		if(move_grounded_instance == other.id){
			move_grounded = false;
			move_grounded_instance = noone;
			// Add stronger downward velocity to ensure falling
			velocity.y = max(velocity.y, 5); // Strong downward push
		}
	}
	
	// PHANTOM PLATFORM: Move platform completely out of the room
	phantom = true;
	x = -10000;
	y = -10000;
	
	// Optional: Play crumble sound
	// audio_sound_play(snd_platform_crumble, AudioChannel.sfx, false, 0);
	
	// Optional: Camera shake
	// camera_shake_add(0.1, 200, 5, 3, false, false, true, 1);
	
	// Optional: Particle effects
	// Create crumble particles/dust
	
	// IMMEDIATELY transition to crumble idle state
	crumble_platform_state = CrumblePlatformState.crumble_idle;
	crumble_idle_time = crumble_idle_time_max;
} 
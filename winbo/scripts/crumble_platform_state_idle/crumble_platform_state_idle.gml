/// @function crumble_platform_state_idle
/// @summary Handle the idle state of the crumble platform
/// @returns {void}
function crumble_platform_state_idle(){
	// Ensure platform is in normal mode (not phantom)
	if(phantom){
		phantom = false;
		x = origin_x;
		y = origin_y;
	}
	
	// Ensure no visual offsets in idle state
	visual_offset_x = 0;
	visual_offset_y = 0;
	
	// Check if crumble should be triggered
	if(crumble_trigger_active){
		// Start crumbling process
		crumble_platform_state = CrumblePlatformState.crumble_countdown;
		crumble_countdown = crumble_countdown_max;
		
		// Optional: Play warning sound/effect
		// audio_sound_play(snd_platform_crumble_warning, AudioChannel.sfx, false, 0);
	}
} 
// Inherit the parent event
event_inherited();

//Game State Switch
switch(global.game_state){
	case GameState.play:
		switch(crumble_platform_state){
			case CrumblePlatformState.idle:
				crumble_platform_state_idle();
			break;
			
			case CrumblePlatformState.crumble_countdown:
				crumble_platform_state_crumble_countdown();
			break;
			
			case CrumblePlatformState.crumble_active:
				crumble_platform_state_crumble_active();
			break;
			
			case CrumblePlatformState.crumble_idle:
				crumble_platform_state_crumble_idle();
			break;
			
			case CrumblePlatformState.respawn_countdown:
				crumble_platform_state_respawn_countdown();
			break;
			
			case CrumblePlatformState.respawn_active:
				crumble_platform_state_respawn_active();
			break;
		}
	break;
}

// Update image animation
image_system_update();
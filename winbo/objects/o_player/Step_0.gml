//Inherit Actor
event_inherited();

//Game State Switch
switch(global.game_state){
	case GameState.play:
		player_gamestate_play();
		
		//Interact System
		interact_system_update();
	break;
	
	case GameState.play_player_hit:
		//State Switch
		switch(state){
			case PlayerState.hit:
				player_state_hit();
			break;
		}
		
		//Image Update
		image_system_update();
	break;
	
	case GameState.dialogue:
		player_gamestate_dialogue();
	break;
	
	case GameState.gameover:
		player_gamestate_gameover();
	break;
	
	case GameState.stop:
	case GameState.menu:
		player_gamestate_stop_game();
	break;
	
	case GameState.level_end_flash:
	case GameState.level_end_celebration:
	case GameState.level_results:
	case GameState.level_end_fade:
		#region Level End Frozen
			// Freeze player in idle sprite
			if(sprite_current != sprite_idle){
				image_system_setup(sprite_idle, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
			}
			
			// Stop all movement
			velocity.Set(0, 0);
			acceleration.Set(0, 0);
			
			// Face forward
			face_horizontal = 1;
			
			// Update image animation
			//image_system_update();
		#endregion
	break;
}
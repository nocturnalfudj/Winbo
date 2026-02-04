//Inherit Actor
event_inherited();

//Game State Switch
switch(global.game_state){
	case GameState.play:
		// Level End Character Behavior (if enabled)
		if(level_end_character_enable){
			door_level_end_character_update();
			
			// Update image animation
			image_system_update();
		}
		
		//Transform Update
		transform_system_update();
	break;
	
	case GameState.gameover:
		//Transform Update
		transform_system_update();
	break;
	
	case GameState.stop:
	case GameState.menu:
		//Transform Update
		transform_system_update();
	break;
	
	case GameState.level_end_celebration:
	case GameState.level_results:
		// Switch to dancing if this is a level end character
		if(level_end_character_enable){
			if(level_end_character_state != LevelEndCharacterState.dancing){
				level_end_character_state = LevelEndCharacterState.dancing;
				if(level_end_character_sprite_dance != noone){
					image_system_setup(level_end_character_sprite_dance, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
				}
			}
			
			// Update image animation
			image_system_update();
		}
		
		//Transform Update
		transform_system_update();
	break;
}
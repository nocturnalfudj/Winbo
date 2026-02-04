/// @function door_level_end_character_update
/// @description Update level end character behavior for doors (state machine, wave animation)
function door_level_end_character_update(){
	// State machine
	switch(level_end_character_state){
		case LevelEndCharacterState.idle:
			// Initialize wave countdown if needed
			if(level_end_character_wave_countdown == noone){
				level_end_character_wave_countdown = new Countdown(5*SECOND, 5*SECOND, true, COUNTDOWN_RESET_COUNT_INFINITE, noone);
			}
			
			// Update wave countdown
			level_end_character_wave_countdown.Update();
			
			// Check if player is in range
			var _player_in_range = false;
			with(o_player){
				var _dist = point_distance(x, y, other.x, other.y);
				if(_dist <= other.level_end_character_wave_check_range){
					_player_in_range = true;
				}
			}
			
			// Trigger wave if countdown finished and player in range
			if(level_end_character_wave_countdown.trigger_active && _player_in_range){
				level_end_character_state = LevelEndCharacterState.waving;
				if(level_end_character_sprite_wave != noone){
					image_system_setup(level_end_character_sprite_wave, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
				}
			}
		break;
		
		case LevelEndCharacterState.waving:
			// Check if wave animation finished
			if(!image.animate){
				// Return to idle
				level_end_character_state = LevelEndCharacterState.idle;
				if(level_end_character_sprite_idle != noone){
					image_system_setup(level_end_character_sprite_idle, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
				}
				
				// Reset wave countdown
				if(level_end_character_wave_countdown != noone){
					level_end_character_wave_countdown.Reset();
				}
			}
		break;
		
		case LevelEndCharacterState.dancing:
			// Just keep dancing (looping animation)
		break;
	}
}
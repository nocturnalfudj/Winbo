// Inherit the parent event
event_inherited();

//Image
sprite_current = spr_door;//director_get_custom_sprite(spr_door);

//Target Room
room_target = r_game;

// Bonus door flag (overridden by o_door_bonus children)
bonus_door_enable = false;

#region Level End Character (Optional)
	// Enable this to make door act as animated level end character
	level_end_character_enable = false;
	
	// Animation sprites (only used if level_end_character_enable = true)
	level_end_character_sprite_idle = noone;
	level_end_character_sprite_wave = noone;
	level_end_character_sprite_dance = noone;
	
	// Wave behavior
	level_end_character_wave_check_range = 800;  // Distance to check for player
	level_end_character_wave_countdown = noone;  // Created on demand
	
	// State machine (only used if level_end_character_enable = true)
	enum LevelEndCharacterState {
		idle,
		waving,
		dancing
	}
	level_end_character_state = LevelEndCharacterState.idle;
	
	// Level end triggered flag
	level_end_character_triggered = false;
	
	// Transition trigger flag
	level_end_character_do_transition = false;
#endregion
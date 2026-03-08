function enemy_apocalypse_survivor_state_sheathe() {
	face_horizontal_draw_enable = true;
	character_health();

	survivor_desired_posture = SurvivorPosture.standing;

	var _sheathe_sprite = enemy_apocalypse_survivor_get_transition_sprite(SurvivorTransition.deaggro);
	if(_sheathe_sprite == noone){
		survivor_transition = SurvivorTransition.deaggro;
		enemy_apocalypse_survivor_finish_transition();
		is_hostile = false;
		hostility_detection_enable = true;
		deaggro_timer = 0;
		attack_countdown = 0;
		attack_face_lock_active = false;
		state = EnemyState.move;
		return;
	}

	if(survivor_transition != SurvivorTransition.deaggro){
		enemy_apocalypse_survivor_start_transition(SurvivorTransition.deaggro);
	}

	velocity.x = 0;
	acceleration.x = 0;
	input_move_magnitude = 0;

	if(sprite_current_frame >= (image.sprite_number - 1)){
		enemy_apocalypse_survivor_finish_transition();
		is_hostile = false;
		hostility_detection_enable = true;
		deaggro_timer = 0;
		attack_countdown = 0;
		attack_face_lock_active = false;
		state = EnemyState.move;
	}

	#region Out of Room
		if((x < 0) || (x > room_width) || (y < 0) || (y > room_height)){
			character_kill();
		}
	#endregion
}

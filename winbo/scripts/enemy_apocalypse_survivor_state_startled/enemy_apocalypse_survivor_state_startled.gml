function enemy_apocalypse_survivor_state_startled(){
	enemy_apocalypse_survivor_posture_sync();

	// Update Health
	character_health();

	// Update target and face direction
	target_update(TargetType.attack);
	if(target[TargetType.attack].x > x){
		face_horizontal = 1;
	}
	else{
		face_horizontal = -1;
	}

	// Progress when animation finishes
	if(sprite_current_frame >= (image.sprite_number - 1)){
		is_hostile = true;
		survivor_desired_posture = SurvivorPosture.standing;
		survivor_transition = SurvivorTransition.startle_to_standing;
		enemy_apocalypse_survivor_finish_transition();
		enemy_apocalypse_survivor_refresh_attack_sprites();
		state = EnemyState.move;
	}
}

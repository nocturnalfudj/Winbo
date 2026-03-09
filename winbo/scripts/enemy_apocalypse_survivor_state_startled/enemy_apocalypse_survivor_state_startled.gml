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
		var _hostile_posture = variable_instance_exists(id, "survivor_hostile_posture")
			? survivor_hostile_posture
			: SurvivorPosture.standing;
		is_hostile = true;
		survivor_desired_posture = SurvivorPosture.standing;
		survivor_transition = SurvivorTransition.startle_to_standing;
		enemy_apocalypse_survivor_finish_transition();
		survivor_desired_posture = _hostile_posture;
		enemy_apocalypse_survivor_refresh_attack_sprites();
		state = EnemyState.move;
	}
}

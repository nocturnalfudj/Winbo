function enemy_apocalypse_survivor_state_startled(){
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
		is_kneeling = true;
		state = EnemyState.move;
	}
}

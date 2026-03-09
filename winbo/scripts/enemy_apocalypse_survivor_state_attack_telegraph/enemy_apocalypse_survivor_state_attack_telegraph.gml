function enemy_apocalypse_survivor_state_attack_telegraph(){
	enemy_apocalypse_survivor_posture_sync();

	// Track aim during telegraph
	character_health();

	var _target_valid = target_update(TargetType.attack);
	if(!_target_valid || target[TargetType.attack] == noone || !target[TargetType.attack].has_valid_target()){
		attack_face_lock_active = false;
		state = EnemyState.move;
		return;
	}

	var _target_x = target[TargetType.attack].x;
	var _target_y = target[TargetType.attack].y;
	var _target_aim_x = _target_x;
	var _target_aim_y = _target_y;

	enemy_apocalypse_survivor_set_target_aim(_target_aim_x, _target_aim_y);
	enemy_apocalypse_survivor_refresh_attack_sprites();

	// Run telegraph countdown + transition using base behaviour
	enemy_state_attack_telegraph();
}

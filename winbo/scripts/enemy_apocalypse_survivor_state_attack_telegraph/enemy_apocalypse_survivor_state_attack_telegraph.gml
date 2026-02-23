function enemy_apocalypse_survivor_state_attack_telegraph(){
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
	var _target_instance = target[TargetType.attack].instance;
	if(_target_instance != noone && instance_exists(_target_instance)){
		_target_aim_x = (_target_instance.bbox_left + _target_instance.bbox_right) * 0.5;
		_target_aim_y = _target_instance.bbox_top + (_target_instance.bbox_bottom - _target_instance.bbox_top) * 0.35;
	}

	aim_angle = point_direction(x, y, _target_aim_x, _target_aim_y);
	face_horizontal = (_target_x >= x) ? 1 : -1;

	// Run telegraph countdown + transition using base behaviour
	enemy_state_attack_telegraph();
}

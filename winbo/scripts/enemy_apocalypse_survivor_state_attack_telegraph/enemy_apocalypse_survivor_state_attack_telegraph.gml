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
	aim_angle = point_direction(x, y, _target_x, _target_y);
	face_horizontal = (_target_x >= x) ? 1 : -1;

	var _aim_data = apocalypse_survivor_get_aim_data();
	if(attack_los_required_enable && attack_los_collision_object != noone){
		var _los_blocked = collision_line(
			_aim_data.muzzle_x, _aim_data.muzzle_y,
			_target_x, _target_y,
			attack_los_collision_object, false, true
		) != noone;
		if(_los_blocked){
			attack_face_lock_active = false;
			state = EnemyState.move;
			return;
		}
	}

	// Run telegraph countdown + transition using base behaviour
	enemy_state_attack_telegraph();
}

function enemy_apocalypse_survivor_state_attack_telegraph(){
	// Track aim during telegraph
	character_health();
	var _dbg_enable = variable_instance_exists(id, "debug_attack_logs_enable") && debug_attack_logs_enable;

	if(_dbg_enable && debug_attack_log_last_state != "telegraph"){
		debug_attack_log_last_state = "telegraph";
		__mcp_log(
			"[ASDBG][STATE] telegraph enter"
			+ " tel_cd=" + string(round(attack_telegraph_countdown))
			+ " atk_cd=" + string(round(attack_countdown))
		);
	}

	var _target_valid = target_update(TargetType.attack);
	if(!_target_valid || target[TargetType.attack] == noone || !target[TargetType.attack].has_valid_target()){
		if(_dbg_enable){
			__mcp_log("[ASDBG][ABORT] telegraph no_target");
		}
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
	var _state_prev = state;
	enemy_state_attack_telegraph();
	if(_dbg_enable && _state_prev == EnemyState.attack_telegraph && state == EnemyState.attack_active){
		__mcp_log(
			"[ASDBG][TRANSITION] telegraph->active"
			+ " tel_cd=" + string(round(attack_telegraph_countdown))
			+ " act_cd=" + string(round(attack_active_countdown))
		);
	}
}

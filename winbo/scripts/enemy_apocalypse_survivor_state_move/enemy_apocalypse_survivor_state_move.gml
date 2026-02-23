function enemy_apocalypse_survivor_state_move(){
	// Relaxed patrol pause logic
	if(!is_hostile){
		if(patrol_pause_cooldown > 0){
			patrol_pause_cooldown -= (time_scale_enable ? global.delta_time_factor_scaled : global.delta_time_factor);
		}
		else if(random(1) < patrol_pause_chance){
			patrol_pause_timer = random_range(patrol_pause_min, patrol_pause_max);
			patrol_pause_cooldown = patrol_pause_cooldown_max;
			state = EnemyState.idle;
			velocity.x = 0;
			acceleration.x = 0;
			input_move_magnitude = 0;
			return;
		}
	}
	else{
		// Hostile posture: kneel/aim and hold position (no chase movement)
		is_kneeling = true;

		// Track aim angle continuously while hostile.
		var _has_target = target_update(TargetType.attack);
		if(_has_target && target[TargetType.attack].has_valid_target()){
			aim_angle = point_direction(x, y, target[TargetType.attack].x, target[TargetType.attack].y);
		}
	}

	// If de-aggro resets hostility, clear kneel flag
	if(!is_hostile && is_kneeling){
		is_kneeling = false;
	}

	// Run shared move logic. While hostile, keep this enemy in place (kneel/aim).
	if(is_hostile){
		var _move_grounded_prev = move_grounded;
		move_grounded = false;
		enemy_state_move();
		move_grounded = _move_grounded_prev;
	}
	else{
		enemy_state_move();
	}

	// If shared logic transitioned state (idle/startled/telegraph/etc.), stop here.
	if(state != EnemyState.move || !is_hostile){
		return;
	}

	// Custom deterministic attack-start gate for apocalypse survivor.
	var _target_valid = target_update(TargetType.attack);
	if(!_target_valid || target[TargetType.attack] == noone || !target[TargetType.attack].has_valid_target()){
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

	if(!target[TargetType.attack].is_within_trigger_distance()){
		return;
	}

	var _v_dist = abs(_target_y - y);
	if(_v_dist > attack_vertical_tolerance){
		return;
	}

	var _aim_data = apocalypse_survivor_get_aim_data();
	var _los_blocked = false;
	if(attack_los_required_enable && attack_los_collision_object != noone){
		_los_blocked = collision_line(
			_aim_data.muzzle_x, _aim_data.muzzle_y,
			_target_aim_x, _target_aim_y,
			attack_los_collision_object, true, true
		) != noone;
	}

	if(_los_blocked || attack_countdown > 0){
		return;
	}

	// Start telegraph state (mirrors base enemy_state_move attack transition).
	state = EnemyState.attack_telegraph;

	var _attack_sprite = sprite_attack_telegraph;
	if(sprite_direction_enable && (sprite_attack_left != noone) && (sprite_attack_right != noone)){
		_attack_sprite = enemy_sprite_get_directional(sprite_attack_left, sprite_attack_right);
	}

	image_system_setup(_attack_sprite, ANIMATION_FPS_DEFAULT * animation_fps_multiplier, true, true, 0, IMAGE_LOOP_FULL);

	attack_face_lock_active = true;
	attack_face_horizontal_lock = face_horizontal;

	attack_active_attack_created = false;
	attack_telegraph_countdown = attack_telegraph_countdown_max;
	attack_active_countdown = attack_telegraph_countdown_max;
	attack_recover_countdown = attack_telegraph_countdown_max;
}

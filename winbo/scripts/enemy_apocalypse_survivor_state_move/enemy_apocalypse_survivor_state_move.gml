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

	var _dbg_enable = variable_instance_exists(id, "debug_attack_logs_enable") && debug_attack_logs_enable;
	var _trigger_dist = target[TargetType.attack].distance_trigger;

	if(_dbg_enable){
		if(debug_attack_log_last_state != "move"){
			__mcp_log("[ASDBG][STATE] move enter atk_cd=" + string(round(attack_countdown)));
			debug_attack_log_last_state = "move";
			debug_attack_log_reason = "";
			debug_attack_log_reason_cooldown = 0;
		}
	}

	var _dbg_log_gate = function(_reason, _h_dist, _h_trig, _v_dist, _v_tol, _los_blocked, _atk_cd){
		if(!(variable_instance_exists(id, "debug_attack_logs_enable") && debug_attack_logs_enable)) return;

		var _delta_time = time_scale_enable ? global.delta_time_factor_scaled : global.delta_time_factor;
		if(debug_attack_log_reason_cooldown > 0){
			debug_attack_log_reason_cooldown -= _delta_time;
		}

		if(debug_attack_log_reason != _reason || debug_attack_log_reason_cooldown <= 0){
			debug_attack_log_reason = _reason;
			debug_attack_log_reason_cooldown = SECOND * 0.75;
			__mcp_log(
				"[ASDBG][GATE] reason=" + _reason
				+ " h=" + string(round(_h_dist)) + "/" + string(round(_h_trig))
				+ " v=" + string(round(_v_dist)) + "/" + string(round(_v_tol))
				+ " los=" + string(_los_blocked ? 1 : 0)
				+ " atk_cd=" + string(round(_atk_cd))
			);
		}
	};

	// Custom deterministic attack-start gate for apocalypse survivor.
	var _target_valid = target_update(TargetType.attack);
	if(!_target_valid || target[TargetType.attack] == noone || !target[TargetType.attack].has_valid_target()){
		_dbg_log_gate("no_target", -1, _trigger_dist, -1, attack_vertical_tolerance, false, attack_countdown);
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

	// Use muzzle-space distances for gating so trigger range matches what the
	// enemy can actually aim/shoot/see from.
	var _aim_data = apocalypse_survivor_get_aim_data();
	var _h_dist = abs(_target_aim_x - _aim_data.muzzle_x);
	var _v_dist = abs(_target_aim_y - _aim_data.muzzle_y);

	if(_h_dist > _trigger_dist){
		_dbg_log_gate("range_x", _h_dist, _trigger_dist, _v_dist, attack_vertical_tolerance, false, attack_countdown);
		return;
	}

	if(_v_dist > attack_vertical_tolerance){
		_dbg_log_gate("range_y", _h_dist, _trigger_dist, _v_dist, attack_vertical_tolerance, false, attack_countdown);
		return;
	}

	// Never begin a shot sequence while off-camera.
	if(!camera_visible){
		_dbg_log_gate("offscreen", _h_dist, _trigger_dist, _v_dist, attack_vertical_tolerance, false, attack_countdown);
		return;
	}
	var _los_blocked = false;
	if(attack_los_required_enable && attack_los_collision_object != noone){
		// Robust LOS: sample multiple points across the target's upper/mid body.
		// This avoids brittle "must be very close" behaviour from a single-point ray.
		_los_blocked = true;

		if(_target_instance != noone && instance_exists(_target_instance)){
			var _sample_x = (_target_instance.bbox_left + _target_instance.bbox_right) * 0.5;
			var _sample_y_min = _target_instance.bbox_top + (_target_instance.bbox_bottom - _target_instance.bbox_top) * 0.25;
			var _sample_y_max = _target_instance.bbox_top + (_target_instance.bbox_bottom - _target_instance.bbox_top) * 0.65;
			var _sample_count = 3;

			for(var _sample_i = 0; _sample_i < _sample_count; _sample_i++){
				var _sample_t = (_sample_count <= 1) ? 0.5 : (_sample_i / (_sample_count - 1));
				var _sample_y = lerp(_sample_y_min, _sample_y_max, _sample_t);

				var _sample_blocked = collision_line(
					_aim_data.muzzle_x, _aim_data.muzzle_y,
					_sample_x, _sample_y,
					attack_los_collision_object, true, true
				) != noone;

				if(!_sample_blocked){
					_los_blocked = false;
					break;
				}
			}
		}
		else{
			_los_blocked = collision_line(
				_aim_data.muzzle_x, _aim_data.muzzle_y,
				_target_aim_x, _target_aim_y,
				attack_los_collision_object, true, true
			) != noone;
		}
	}

	if(_los_blocked){
		_dbg_log_gate("los_blocked", _h_dist, _trigger_dist, _v_dist, attack_vertical_tolerance, true, attack_countdown);
		return;
	}

	if(attack_countdown > 0){
		_dbg_log_gate("cooldown", _h_dist, _trigger_dist, _v_dist, attack_vertical_tolerance, false, attack_countdown);
		return;
	}

	if(_dbg_enable){
		debug_attack_log_reason = "";
		debug_attack_log_reason_cooldown = 0;
		__mcp_log(
			"[ASDBG][ATTACK] start_telegraph"
			+ " h=" + string(round(_h_dist)) + "/" + string(round(_trigger_dist))
			+ " v=" + string(round(_v_dist)) + "/" + string(round(attack_vertical_tolerance))
			+ " atk_cd=" + string(round(attack_countdown))
		);
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

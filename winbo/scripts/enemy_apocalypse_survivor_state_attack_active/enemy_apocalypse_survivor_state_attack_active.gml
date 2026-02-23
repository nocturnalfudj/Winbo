function enemy_apocalypse_survivor_state_attack_active(){
	// Update Health
	character_health();
	var _dbg_enable = variable_instance_exists(id, "debug_attack_logs_enable") && debug_attack_logs_enable;

	if(_dbg_enable && debug_attack_log_last_state != "active"){
		debug_attack_log_last_state = "active";
		__mcp_log(
			"[ASDBG][STATE] active enter"
			+ " act_cd=" + string(round(attack_active_countdown))
			+ " atk_cd=" + string(round(attack_countdown))
			+ " spawned=" + string(attack_active_attack_created ? 1 : 0)
		);
	}

	var _delta_time = time_scale_enable ? global.delta_time_factor_scaled : global.delta_time_factor;

	// Keep tracking aim while active
	var _target_valid = target_update(TargetType.attack);
	if(!_target_valid || target[TargetType.attack] == noone || !target[TargetType.attack].has_valid_target()){
		if(_dbg_enable){
			__mcp_log("[ASDBG][ABORT] active no_target");
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

	var _aim_data = apocalypse_survivor_get_aim_data();

	// Fire once, at configured animation frame (or immediately if frame 0)
	if(!camera_visible){
		if(_dbg_enable && !variable_instance_exists(id, "_asdbg_active_offscreen_logged")){
			_asdbg_active_offscreen_logged = false;
		}
		if(_dbg_enable && !_asdbg_active_offscreen_logged){
			__mcp_log("[ASDBG][BLOCK] active offscreen fire_blocked");
			_asdbg_active_offscreen_logged = true;
		}
	}
	else{
		if(variable_instance_exists(id, "_asdbg_active_offscreen_logged")){
			_asdbg_active_offscreen_logged = false;
		}
	}

	if(!attack_active_attack_created && sprite_current_frame >= attack_projectile_spawn_frame){
		if(!camera_visible){
			// Never fire while off-camera.
		}
		else{
		// Start cooldown only when a shot is actually fired.
		attack_countdown = attack_countdown_max;

		var _b = instance_create_layer(_aim_data.muzzle_x, _aim_data.muzzle_y, "lyr_player", o_bullet);
		with(_b){
			team = other.team;
			damage = other.attack_projectile_damage;
			acceleration.AddMagnitudeDirection(other.attack_projectile_speed, other.aim_angle);
		}

		// Recoil (push opposite to shot)
		if(attack_recoil_enable){
			velocity.AddMagnitudeDirection(attack_recoil_amount, aim_angle + 180);
		}

		// Muzzle flash / shell timers (Draw uses asset_get_index so safe even if missing)
		muzzle_flash_timer = muzzle_flash_timer_max;
		shell_timer = shell_timer_max;

		attack_active_attack_created = true;

		if(_dbg_enable){
			debug_attack_log_shot_count += 1;
			__mcp_log(
				"[ASDBG][FIRE] shot=" + string(debug_attack_log_shot_count)
				+ " frame=" + string(round(sprite_current_frame))
				+ " atk_cd=" + string(round(attack_countdown))
				+ " aim=" + string(round(aim_angle))
			);
		}
		}
	}

	// Count down active
	if(attack_active_countdown > 0){
		attack_active_countdown -= _delta_time;
	}

	// Progress to recover
	var _trigger_recover = false;
	if(attack_active_progress_at_end_of_animation){
		if(sprite_current_frame >= (image.sprite_number - 1)) _trigger_recover = true;
	}
	else if(attack_active_countdown <= 0){
		_trigger_recover = true;
	}

	if(_trigger_recover){
		if(_dbg_enable){
			__mcp_log(
				"[ASDBG][TRANSITION] active->recover"
				+ " act_cd=" + string(round(attack_active_countdown))
				+ " spawned=" + string(attack_active_attack_created ? 1 : 0)
			);
		}
		state = EnemyState.attack_recover;
		image_system_setup(sprite_attack_recover, ANIMATION_FPS_DEFAULT * animation_fps_multiplier, true, true, 0, IMAGE_LOOP_FULL);
	}
}

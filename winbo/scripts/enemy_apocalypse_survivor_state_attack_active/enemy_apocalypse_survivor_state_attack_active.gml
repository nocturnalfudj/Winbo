function enemy_apocalypse_survivor_state_attack_active(){
	// Update Health
	character_health();

	var _delta_time = time_scale_enable ? global.delta_time_factor_scaled : global.delta_time_factor;

	// Reset attack cooldown once (on entry)
	if(!attack_active_attack_created){
		attack_countdown = attack_countdown_max;
	}

	// Keep tracking aim while active
	target_update(TargetType.attack);
	aim_angle = point_direction(x, y, target[TargetType.attack].x, target[TargetType.attack].y);
	face_horizontal = (target[TargetType.attack].x >= x) ? 1 : -1;

	// Fire once, at configured animation frame (or immediately if frame 0)
	if(!attack_active_attack_created && sprite_current_frame >= attack_projectile_spawn_frame){
		// Compute body sprite draw angle and select barrel offset (mirrors Draw_0.gml sector/rotation logic)
		var _draw_angle = 0;
		var _barrel_x, _barrel_y;
		var _a = aim_angle;
		if(_a >= 315 || _a < 45){
			_draw_angle = _a - 2;       // side (measured neutral = 2°)
			_barrel_x = barrel_offset_x_side;
			_barrel_y = barrel_offset_y_side;
		}
		else if(_a >= 45 && _a < 85){
			_draw_angle = _a - 44.5;    // diag (measured neutral = 44.5°)
			_barrel_x = barrel_offset_x_diag;
			_barrel_y = barrel_offset_y_diag;
		}
		else if(_a >= 85 && _a < 95){
			_draw_angle = _a - 90;      // up
			_barrel_x = barrel_offset_x_up;
			_barrel_y = barrel_offset_y_up;
		}
		else if(_a >= 95 && _a < 135){
			_draw_angle = _a - 135.5;   // diag_flip (measured neutral = 135.5°)
			_barrel_x = barrel_offset_x_diag;
			_barrel_y = barrel_offset_y_diag;
		}
		else if(_a >= 135 && _a < 225){
			_draw_angle = _a - 178;     // side_flip (measured neutral = 178°)
			_barrel_x = barrel_offset_x_side;
			_barrel_y = barrel_offset_y_side;
		}
		else{
			// 225-315: "out" sector, no rotation, use side offset
			_barrel_x = barrel_offset_x_side;
			_barrel_y = barrel_offset_y_side;
		}

		// Rotate spawn offset to match body sprite rotation
		var _base_x = _barrel_x * face_horizontal;
		var _base_y = _barrel_y;
		var _off_dist = point_distance(0, 0, _base_x, _base_y);
		var _off_dir = point_direction(0, 0, _base_x, _base_y);
		var _spawn_x = x + lengthdir_x(_off_dist, _off_dir + _draw_angle);
		var _spawn_y = y + lengthdir_y(_off_dist, _off_dir + _draw_angle);

		var _b = instance_create_layer(_spawn_x, _spawn_y, "lyr_player", o_bullet);
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
		state = EnemyState.attack_recover;
		image_system_setup(sprite_attack_recover, ANIMATION_FPS_DEFAULT * animation_fps_multiplier, true, true, 0, IMAGE_LOOP_FULL);
	}
}

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
		// Spawn a fast bullet along aim_angle
		var _spawn_x = x + (attack_projectile_spawn_offset_x * face_horizontal);
		var _spawn_y = y + attack_projectile_spawn_offset_y;

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

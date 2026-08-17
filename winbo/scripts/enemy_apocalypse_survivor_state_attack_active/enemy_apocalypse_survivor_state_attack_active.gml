function enemy_apocalypse_survivor_state_attack_active(){
	enemy_apocalypse_survivor_posture_sync();

	// Update Health
	character_health();

	var _delta_time = time_scale_enable ? global.delta_time_factor_scaled : global.delta_time_factor;

	// Keep tracking aim while active
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

	var _aim_data = apocalypse_survivor_get_aim_data();

	// Fire once, at configured animation frame (or immediately if frame 0)
	if(!attack_active_attack_created && sprite_current_frame >= attack_projectile_spawn_frame){
		if(!camera_visible){
			// Never fire while off-camera.
		}
		else{
			// Start cooldown only when a shot is actually fired.
			attack_countdown = attack_countdown_max;

			var _b = instance_create_layer(_aim_data.fire_x, _aim_data.fire_y, "lyr_player", o_bullet);
			with(_b){
				team = other.team;
				damage = other.attack_projectile_damage;
				sprite_index = spr_apocalypse_survivor_projectile;
				sprite_current = spr_apocalypse_survivor_projectile;
				image_system_setup(spr_apocalypse_survivor_projectile,12,true,true,0,IMAGE_LOOP_FULL);
				mask_index = spr_apocalypse_survivor_projectile;
				sprite_angle_offset = 180;
				death_anim_sprite = spr_apocalypse_survivor_projectile_impact;
				death_anim_fps = 18;
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
		attack_recover_countdown = attack_recover_countdown_max;
		state = EnemyState.attack_recover;
		image_system_setup(sprite_attack_recover, ANIMATION_FPS_DEFAULT * animation_fps_multiplier, true, true, 0, IMAGE_LOOP_FULL);
	}
}

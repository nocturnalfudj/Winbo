function enemy_apocalypse_survivor_state_move(){
	enemy_apocalypse_survivor_posture_sync();
	var _was_hostile = is_hostile;

	if(!is_hostile){
		survivor_desired_posture = SurvivorPosture.standing;
		if(survivor_posture != SurvivorPosture.standing){
			enemy_apocalypse_survivor_set_posture(SurvivorPosture.standing);
		}
		survivor_transition = SurvivorTransition.none;
	}
	else{
		var _hostile_target = target_update(TargetType.attack);
		if(_hostile_target && target[TargetType.attack].has_valid_target()){
			enemy_apocalypse_survivor_set_target_aim(target[TargetType.attack].x, target[TargetType.attack].y);
		}

		if(survivor_transition == SurvivorTransition.none && survivor_desired_posture != survivor_posture){
			var _posture_transition = SurvivorTransition.crouch_to_stand;
			if(survivor_desired_posture == SurvivorPosture.crouched){
				_posture_transition = SurvivorTransition.stand_to_crouch;
			}
			enemy_apocalypse_survivor_start_transition(_posture_transition);
		}
	}

	if((survivor_transition == SurvivorTransition.stand_to_crouch) || (survivor_transition == SurvivorTransition.crouch_to_stand)){
		character_health();
		velocity.x = 0;
		acceleration.x = 0;
		input_move_magnitude = 0;

		if(sprite_current_frame >= (image.sprite_number - 1)){
			enemy_apocalypse_survivor_finish_transition();
			enemy_apocalypse_survivor_refresh_attack_sprites();
		}
		return;
	}

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
		// Hostile posture: hold position and track aim continuously.
		var _has_target = target_update(TargetType.attack);
		if(_has_target && target[TargetType.attack].has_valid_target()){
			enemy_apocalypse_survivor_set_target_aim(target[TargetType.attack].x, target[TargetType.attack].y);
		}
	}

	// Run shared move logic. While hostile, keep this enemy in place (layered aim/hold).
	if(is_hostile){
		var _move_grounded_prev = move_grounded;
		move_grounded = false;
		enemy_state_move();
		move_grounded = _move_grounded_prev;
	}
	else{
		enemy_state_move();
	}

	// Base re-aggro skips the startled state after the first encounter,
	// so restore this variant's intended hostile posture here.
	if(!_was_hostile && is_hostile && state == EnemyState.move){
		survivor_desired_posture = variable_instance_exists(id, "survivor_hostile_posture")
			? survivor_hostile_posture
			: SurvivorPosture.standing;

		if(survivor_transition == SurvivorTransition.none && survivor_desired_posture != survivor_posture){
			var _reaggro_transition = SurvivorTransition.crouch_to_stand;
			if(survivor_desired_posture == SurvivorPosture.crouched){
				_reaggro_transition = SurvivorTransition.stand_to_crouch;
			}

			enemy_apocalypse_survivor_start_transition(_reaggro_transition);
			velocity.x = 0;
			acceleration.x = 0;
			input_move_magnitude = 0;
			return;
		}
	}

	// If shared logic transitioned state (idle/startled/telegraph/etc.), stop here.
	if(state != EnemyState.move || !is_hostile){
		if(state == EnemyState.startled){
			survivor_desired_posture = SurvivorPosture.standing;
			survivor_transition = SurvivorTransition.startle_to_standing;
		}
		return;
	}

	var _trigger_dist = target[TargetType.attack].distance_trigger;

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

	enemy_apocalypse_survivor_set_target_aim(_target_aim_x, _target_aim_y);

	// Use muzzle-space distances for gating so trigger range matches what the
	// enemy can actually aim/shoot/see from.
	var _aim_data = apocalypse_survivor_get_aim_data();
	var _h_dist = abs(_target_aim_x - _aim_data.fire_x);
	var _v_dist = abs(_target_aim_y - _aim_data.fire_y);

	if(_h_dist > _trigger_dist){
		return;
	}

	if(_v_dist > attack_vertical_tolerance){
		return;
	}

	// Never begin a shot sequence while off-camera.
	if(!camera_visible){
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
						_aim_data.fire_x, _aim_data.fire_y,
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
				_aim_data.fire_x, _aim_data.fire_y,
				_target_aim_x, _target_aim_y,
				attack_los_collision_object, true, true
			) != noone;
		}
	}

	if(_los_blocked){
		return;
	}

	if(attack_countdown > 0){
		return;
	}

	// Start telegraph state (mirrors base enemy_state_move attack transition).
	state = EnemyState.attack_telegraph;
	enemy_apocalypse_survivor_refresh_attack_sprites();

	var _attack_sprite = sprite_attack_telegraph;
	if(sprite_direction_enable && (sprite_attack_left != noone) && (sprite_attack_right != noone)){
		_attack_sprite = enemy_sprite_get_directional(sprite_attack_left, sprite_attack_right);
	}

	image_system_setup(_attack_sprite, ANIMATION_FPS_DEFAULT * animation_fps_multiplier, true, true, 0, IMAGE_LOOP_FULL);

	attack_face_lock_active = true;
	attack_face_horizontal_lock = face_horizontal;

	attack_active_attack_created = false;
	attack_telegraph_countdown = attack_telegraph_countdown_max;
	attack_active_countdown = attack_active_countdown_max;
	attack_recover_countdown = attack_recover_countdown_max;
}

function enemy_space_ranger_state_attack(){
	// Enable face flip for attack sprites (left-facing, needs flip system)
	face_horizontal_draw_enable = true;

	// Update Health
	character_health();
	
	// Delta Time Factor
	var _delta_time;
	if(time_scale_enable)
		_delta_time = global.delta_time_factor_scaled;
	else
		_delta_time = global.delta_time_factor;
	
	// Debug: Log entry
	if (!variable_instance_exists(id, "_atk_log_count")) _atk_log_count = 0;
	_atk_log_count++;
	if (_atk_log_count == 1) {
		__mcp_log("[ATK] ENTERED cd=" + string(round(attack_active_countdown)) + " created=" + string(attack_active_attack_created));
	}
	
	#region Combat - Fire Missile
		// Reset Attack Countdown (should only happen once, not every frame!)
		if (_atk_log_count == 1) {
			attack_countdown = attack_countdown_max;
		}

		// Create Missile (only once, on the correct animation frame)
		if(!attack_active_attack_created && sprite_current_frame >= missile_spawn_frame){
			// Fire in the locked aim direction (attack animation is rotated to match)
			var _fire_direction = attack_locked_angle;

			__mcp_log("[ATK] FIRING missile at frame " + string(sprite_current_frame) + ", dir=" + string(_fire_direction) + ", face=" + string(face_horizontal));

			// Calculate spawn position — rotate the base offset by the locked draw angle
			var _xscale_factor = face_horizontal * sprite_face_direction;
			var _base_offset_x = (_xscale_factor < 0) ? -missile_spawn_offset_x : missile_spawn_offset_x;
			var _base_offset_y = missile_spawn_offset_y;

			// Rotate offset to match the rotated attack sprite
			var _offset_dist = point_distance(0, 0, _base_offset_x, _base_offset_y);
			var _offset_angle = point_direction(0, 0, _base_offset_x, _base_offset_y);
			var _rotated_angle = _offset_angle + attack_locked_draw_angle;
			var _spawn_x = x + lengthdir_x(_offset_dist, _rotated_angle);
			var _spawn_y = y + lengthdir_y(_offset_dist, _rotated_angle);

			// Create missile instance
			var _missile = instance_create_layer(_spawn_x, _spawn_y, "lyr_player", missile_object);
			with(_missile){
				// Set team
				team = other.team;

				// Set damage
				damage = other.missile_damage;

				// Set velocity toward target
				acceleration.AddMagnitudeDirection(other.missile_speed, _fire_direction);
			}

			// Apply recoil effect
			if(attack_recoil_enable){
				var _recoil_dir = _fire_direction + 180;
				velocity.AddMagnitudeDirection(attack_recoil_amount, _recoil_dir);
			}

			// Attack Created
			attack_active_attack_created = true;
		}
		
		// Run Active Countdown
		if(attack_active_countdown > 0){
			attack_active_countdown -= _delta_time;
		}
		
		// Progress when animation finishes
		var _trigger_recover = false;
		
		if(attack_active_progress_at_end_of_animation){
			if(sprite_current_frame >= (image.sprite_number - 1)){
				_trigger_recover = true;
			}
		}
		else if(attack_active_countdown <= 0){
			_trigger_recover = true;
		}
		
		// Trigger Recover
		if(_trigger_recover){
			__mcp_log("[ATK] -> RECOVER cnt=" + string(_atk_log_count) + " frm=" + string(sprite_current_frame));
			_atk_log_count = 0;

			// Rotation eases back to 0 during the attack animation recovery frames.
			// Once we leave attack_active, normal draw resumes (no rotated draw in recover/move).
			attack_locked_draw_angle = 0;
			attack_rotation_active = false;
			
			// Go to Attack Recover State
			state = EnemyState.attack_recover;
			
			// Update Sprite
			image_system_setup(sprite_attack_recover, ANIMATION_FPS_DEFAULT * animation_fps_multiplier, true, true, 0, IMAGE_LOOP_FULL);
		}
	#endregion
	
	#region Out of Room
		if((x < 0) || (x > room_width) || (y < 0) || (y > room_height)){
			character_kill();
		}
	#endregion
}

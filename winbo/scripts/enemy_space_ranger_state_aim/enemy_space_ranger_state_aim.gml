function enemy_space_ranger_state_aim(){
	// Enable face flip for aim sprites (left-facing, needs flip system)
	face_horizontal_draw_enable = true;

	// Update Health
	character_health();
	
	// Delta Time Factor
	var _delta_time;
	if(time_scale_enable)
		_delta_time = global.delta_time_factor_scaled;
	else
		_delta_time = global.delta_time_factor;
	
	// Debug: Log every 30 frames in telegraph
	if (!variable_instance_exists(id, "_aim_log_count")) _aim_log_count = 0;
	_aim_log_count++;
	if (_aim_log_count == 1 || _aim_log_count % 30 == 0) {
		__mcp_log("[AIM] cd=" + string(round(attack_telegraph_countdown)) + " dt=" + string(_delta_time) + " cnt=" + string(_aim_log_count));
	}
	
	#region Combat - Aiming
		// Update Target
		target_update(TargetType.attack);
		
		// Calculate aim angle toward player
		if(target[TargetType.attack] == noone){
			// Target lost during aim — return to move state
			state = EnemyState.move;
			return;
		}
		var _target_x = target[TargetType.attack].x;
		var _target_y = target[TargetType.attack].y;
		aim_angle = point_direction(x, y, _target_x, _target_y);

		// Update face direction based on target (standard logic)
		if(_target_x > x){
			face_horizontal = 1;
		}
		else{
			face_horizontal = -1;
		}
		
		// Lock facing for attack
		attack_face_lock_active = true;
		attack_face_horizontal_lock = face_horizontal;

		// Aim-in: if we're using the full attack sequence as the telegraph,
		// play frames 0-6 once, then hold on frame 6 while continuing to rotate.
		if(sprite_current == spr_space_ranger_attack){
			if(sprite_current_frame >= 6){
				if(image != noone){
					image.animate = false;
				}
				image_set_frame(image, 6);
			}
		}
		
		// Run Telegraph Countdown
		if(attack_telegraph_countdown > 0){
			attack_telegraph_countdown -= _delta_time;
		}
		
		// Progress to attack when countdown finishes
		// (Also require the aim-in frames to have completed so we don't cut early.)
		if(attack_telegraph_countdown <= 0 && sprite_current_frame >= 6){
			__mcp_log("[AIM] -> ACTIVE, cnt=" + string(_aim_log_count) + " flag_before=" + string(attack_active_attack_created));
			_aim_log_count = 0;

			// Lock the current aim angle for the attack/recover animation rotation
			attack_locked_angle = aim_angle;
			attack_rotation_active = true;
			if(face_horizontal == 1){
				attack_locked_draw_angle = aim_angle;
			}
			else{
				attack_locked_draw_angle = aim_angle + 180;
			}

			// Go to Attack Active State
			state = EnemyState.attack_active;

			// Reset attack created flag
			attack_active_attack_created = false;

			__mcp_log("[AIM] flag_after=" + string(attack_active_attack_created));

			// Resume the same attack sprite from frame 6 onward (do not reset the animation)
			if(image != noone){
				image.animate = true;
				image.loop = false;
			}
		}
	#endregion
	
	#region Out of Room
		if((x < 0) || (x > room_width) || (y < 0) || (y > room_height)){
			character_kill();
		}
	#endregion
}

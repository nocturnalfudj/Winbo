function enemy_state_attack_recover(){
	// Debug: Log entry for Space Ranger
	if (object_index == o_enemy_space_ranger) {
		if (!variable_instance_exists(id, "_rec_log_count")) _rec_log_count = 0;
		_rec_log_count++;
		if (_rec_log_count == 1) {
			__mcp_log("[REC] ENTERED cd=" + string(round(attack_recover_countdown)));
		}
	}

	//Update Health
	character_health();
	
	//Detla Time Factor
	var _delta_time;
	if(time_scale_enable)
		_delta_time = global.delta_time_factor_scaled;
	else
		_delta_time = global.delta_time_factor;
	
	#region Combat
		//Run Recover Countdown
		if(attack_recover_countdown > 0){
			attack_recover_countdown -= _delta_time;
		}
		
		var _trigger_idle;
		_trigger_idle = false;
		
		//Frame-based progression
		if(attack_recover_progress_at_frame_enable){
			if(sprite_current_frame >= attack_recover_progress_at_frame){
				_trigger_idle = true;
			}
		}
		//Progress When Animation Finishes
		else if(attack_recover_progress_at_end_of_animation){
			//Animation Finished
			if(sprite_current_frame >= (image.sprite_number - 1)){
				_trigger_idle = true;
			}
		}
		else if(attack_recover_countdown <= 0){
			_trigger_idle = true;
		}
		
		//Trigger Idle
		if(_trigger_idle){
			// Debug log
			if (object_index == o_enemy_space_ranger) {
				__mcp_log("[REC] -> MOVE cnt=" + string(_rec_log_count) + " frm=" + string(sprite_current_frame));
				_rec_log_count = 0;
			}
			
			// Unlock facing after the attack completes
			attack_face_lock_active = false;
			
			//Go to Move State (animation will be set based on is_hostile)
			state = EnemyState.move;
		}
	#endregion
	
	#region Out of Room
		if((x < 0) || (x > room_width) || (y < 0) || (y > room_height)){
			character_kill();
		}
	#endregion
}
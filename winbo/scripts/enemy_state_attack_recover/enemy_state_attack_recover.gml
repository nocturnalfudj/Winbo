function enemy_state_attack_recover(){
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

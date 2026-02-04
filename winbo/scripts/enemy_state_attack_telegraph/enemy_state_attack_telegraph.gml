function enemy_state_attack_telegraph(){
	//Update Health
	character_health();
	
	//Detla Time Factor
	var _delta_time;
	if(time_scale_enable)
		_delta_time = global.delta_time_factor_scaled;
	else
		_delta_time = global.delta_time_factor;
	
	#region Combat
		//Update Target
		target_update(TargetType.attack);
		
		// Update Face (locked for the full attack once telegraph begins)
		if(attack_face_lock_active){
			face_horizontal = attack_face_horizontal_lock;
		}
		else{
			if(target[TargetType.attack].x > x){
				face_horizontal = 1;
			}else{
				face_horizontal = -1;
			}
			
			// Lock on first telegraph frame as a safety net (in case a caller forgot to lock)
			attack_face_lock_active = true;
			attack_face_horizontal_lock = face_horizontal;
		}
		
		//Run Telegraph Countdown
		if(attack_telegraph_countdown > 0){
			attack_telegraph_countdown -= _delta_time;
		}
		
		var _trigger_attack;
		_trigger_attack = false;
		
		//Frame-based progression
		if(attack_telegraph_progress_at_frame_enable){
			if(sprite_current_frame >= attack_telegraph_progress_at_frame){
				_trigger_attack = true;
			}
		}
		//Progress When Animation Finishes
		else if(attack_telegraph_progress_at_end_of_animation){
			//Animation Finished
			if(sprite_current_frame >= (image.sprite_number - 1)){
				_trigger_attack = true;
			}
		}
		else if(attack_telegraph_countdown <= 0){
			_trigger_attack = true;
		}
		
		//Trigger Attack
		if(_trigger_attack){
			//Go to Attack Active State
			state = EnemyState.attack_active;
			
			//Attack Created Reset
			attack_active_attack_created = false;
			
			//Update Sprite (unless using combined sprite)
			if(!attack_active_skip_sprite_change){
				image_system_setup(sprite_attack_active,ANIMATION_FPS_DEFAULT * animation_fps_multiplier,true,true,0,IMAGE_LOOP_FULL);
			}
		}
	#endregion
	
	#region Out of Room
		if((x < 0) || (x > room_width) || (y < 0) || (y > room_height)){
			character_kill();
		}
	#endregion
}
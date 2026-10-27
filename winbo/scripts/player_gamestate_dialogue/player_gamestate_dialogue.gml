function player_gamestate_dialogue(){
	var _delta_time_scaled;
	_delta_time_scaled = global.delta_time_factor_scaled;
	
	#region Countdowns
		//Bump Allow
		if(bump_allow_countdown > 0){
			bump_allow_countdown -= _delta_time_scaled;
		}
		else{
			bump_allow = false;
		}
		
		//Float
		if(float_countdown > 0){
			float_countdown -= _delta_time_scaled;
		}
		
		//Spring
		if(spring_countdown > 0){
			spring_countdown -= _delta_time_scaled;
		}
		
		//Jump Hold Allow  
		if(jump_hold_allow_countdown > 0){
			jump_hold_allow_countdown -= _delta_time_scaled;
		}
	#endregion

	#region Movement Update
		movement_system_update();

		//Stationary
		if(velocity_mag > 0.05){
			stationary = false;
			stationary_time = 0;
		}
		else{
			stationary = true;
			stationary_time += _delta_time_scaled;
		}
		
		#region Landing Animation
			if(second_jump_landing_armed && !move_grounded) second_jump_airborne_seen = true;
			// Share the landing edge with normal play so resuming cannot consume it twice.
			var _was_jump_grounded = jump_grounded;
			jump_grounded = player_jump_grounded();
			if(!swim_active && (state == PlayerState.move || state == PlayerState.float)
			&& jump_grounded && !_was_jump_grounded){
				// Sitting is checked below before the normal animation update.
				player_land_begin();
			}
		#endregion

		#region Sitting
			var _bump_block, _landing_block;
			_bump_block = (sprite_current == sprite_bump) && (sprite_current_frame < (image.sprite_number - 1));
		
			// Block sprite changes while landing animation is playing and not complete
			_landing_block = player_landing_playing();
		
			//Not Bumping and Not Landing
			if(!_bump_block && !_landing_block){
				if(move_grounded){
					if(sprite_current != sprite_sitdown && sprite_current != sprite_dialogue_idle){
						image_system_setup(sprite_sitdown, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
					}
					else if((sprite_current == sprite_sitdown) && (sprite_current_frame >= image.sprite_number - 1)){
						image_system_setup(sprite_dialogue_idle, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
					}
				}
			}
		#endregion
	#endregion
	
	//Image Update
	image_system_update();

	//Transform Update
	transform_system_update();

	//PFX System Execute
	//pfx_system_execute();
}

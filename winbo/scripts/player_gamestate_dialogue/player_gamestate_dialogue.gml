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
			if((state == PlayerState.move) || (state == PlayerState.float)){
				// Check if we should trigger landing animation (just became grounded)
				var _should_start_landing = false;
				_should_start_landing = (move_grounded && !move_grounded_previous);
		
				// Start landing animation if needed
				if(_should_start_landing){
					// Landing Sprite - Choose between normal and sideways land
					if(sprite_current != sprite_land && sprite_current != sprite_land_sideways){
					    // Determine which land sprite to use based on horizontal velocity
					    var _use_sideways_land = (abs(velocity.x) > 5);
					    var _target_sprite = _use_sideways_land ? sprite_land_sideways : sprite_land;

					    image_system_setup(_target_sprite,ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
					}
					else{
					    // Already in a land sprite - check if we need to switch between them
					    var _should_use_sideways = (abs(velocity.x) > 5);
					    var _current_is_sideways = (sprite_current == sprite_land_sideways);

					    if(_should_use_sideways != _current_is_sideways){
					        // Need to switch land sprites while preserving frame position
					        var _current_frame = image.frame;
					        var _target_sprite = _should_use_sideways ? sprite_land_sideways : sprite_land;

					        // Use image_set_sprite with position_reset = false to preserve frame
					        image_set_sprite(image, _target_sprite, false);
					    }
					}
				}
			}
		#endregion
		
		#region Sitting
			var _bump_block, _landing_block;
			_bump_block = (sprite_current == sprite_bump) && (sprite_current_frame < (image.sprite_number - 1));
		
			// Block sprite changes while landing animation is playing and not complete
			_landing_block = ((sprite_current == sprite_land) || (sprite_current == sprite_land_sideways)) && (sprite_current_frame < (image.sprite_number - 1));
		
			//Not Bumping and Not Landing
			if(!_bump_block && !_landing_block){
				if(move_grounded){
					if(sprite_current != sprite_sitdown){
						image_system_setup(sprite_sitdown,ANIMATION_FPS_DEFAULT, true, true, 17, IMAGE_LOOP_FULL);
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
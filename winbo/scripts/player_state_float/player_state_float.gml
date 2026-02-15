function player_state_float(){
	#region Sprite Update
		var _bump_block
		_bump_block = (sprite_current == sprite_bump) && (sprite_current_frame == (image.sprite_number - 1));
	
		//Not Bumping and Not Playing Queued Animation
		if(!_bump_block && !image.is_playing_queued){
			//Float Sprite
			if(sprite_current != sprite_float)
				image_system_setup(sprite_float,ANIMATION_FPS_DEFAULT,true,true,5,IMAGE_LOOP_FULL);
		}
	#endregion
	
	//Update Health
	character_health();
	
	//Input
	player_input();
	acceleration.AddMagnitudeDirection(INPUT_MOVE_ACCELERATION*input_move_magnitude,input_move_direction);
	
	#region Arrow Input
		//Jump
		if(keyboard_check(vk_up)){
			input_current[UserControl.jump] = true;
		}
		
		//Down
		if(keyboard_check_pressed(vk_down)){
			input_current[UserControl.down] = true;
		}
		
		//Dash
		var _left_key,_right_key;
		_left_key = keyboard_check_pressed(vk_left);
		_right_key = keyboard_check_pressed(vk_right);
	
		if(_left_key || _right_key){
			//Dash
			input_current[UserControl.dash] = true;
		
			if(_left_key)
				input_move_direction = 180;
			else if(_right_key)
				input_move_direction = 0;
			
			input_move_magnitude = 1;
			
			input_aim_direction = input_move_direction;
		}
		
		//Float
		if((!input_current[UserControl.float]) && (!keyboard_check(vk_up))){
			//Go to Move State
			state = PlayerState.move;
		}
		
		//Moving Upward
		if((acceleration.y < 0) || (velocity.y < 0)){
			//Go to Move State
			state = PlayerState.move;
		}
	#endregion
	
	//Update Dash No Input Direction
	if(input_move_magnitude > 0){
		dash_no_input_direction = input_move_direction;
	}
	
	#region Jump
		//Input Pressed
		if((input_current[UserControl.jump]) && (!input_previous[UserControl.jump])){
			var _close_enough_to_jump;
			_close_enough_to_jump = false;
			if(move_grounded_close){
				//Moving Down
				if(velocity.y > 0){
					_close_enough_to_jump = true;
				}
			}
			
			//Bump Jump
			//OR
			//Grounded
			if((bump_jump_count) || (move_grounded) || (_close_enough_to_jump)){
				//Accelerate Upward
				acceleration.AddMagnitudeDirection(input_move_acceleration_jump,90);
				
				//Reset Jump Hold Countdown for Variable Jump
				jump_hold_allow_countdown = jump_hold_allow_countdown_max;
			
				//Start with Rise Gravity
				move_gravity.Copy(move_gravity_rise);	
				
				//Reduce Bump Jump
				if(bump_jump_count > 0){
					bump_jump_count--;
				}
				
				// Tell camera to dampen vertical follow during jump
					with(o_camera){
						if(follow_jump_dampening_enable){
							follow_jump_dampening_factor = 0;
						}
					}
					
					// Jumping smoke FX (ground puff)
					var _jump_smoke_sprite = (input_move_magnitude > 0.1) ? spr_smoke_jump_diagonal : spr_smoke_jump_upward;
					var _jump_smoke_xscale = 1;
					if (input_move_magnitude > 0.1) {
						// The diagonal jump smoke art faces left by default; flip so it matches travel direction.
						_jump_smoke_xscale = (input_move_direction > 90 && input_move_direction < 270) ? 1 : -1;
					}
					fx_spawn_sprite_once(x, bbox_bottom, "lyr_pfx_foreground", _jump_smoke_sprite, _jump_smoke_xscale, 1, 0, ANIMATION_FPS_DEFAULT);
				}
			}
	#endregion
	
	#region Jump Hold (Variable Jump Height)
		//Can Jump Hold
		if(jump_hold_enable && !move_grounded){
			//If Jump Input Ever Released
			if(!input_current[UserControl.jump]){
				//Stop variable jump
				jump_hold_allow_countdown = 0;
			}
			
			//Jump Input Held and countdown still active
			if(input_current[UserControl.jump] && jump_hold_allow_countdown > 0){
				//Add Additional Jump Acceleration
				acceleration.AddMagnitudeDirection(input_move_acceleration_jump * 0.01, 90);
			}
		}
	#endregion
	
	#region Grounded
		if(move_grounded){
			//Refill Dash Stamina
			dash_stamina = dash_stamina_max;
			dash_stamina_depleted = false;
			
			//Reset Float Countdown
			float_countdown = float_countdown_max;
		}
	#endregion
	
	#region Drop Through
		// Check if player wants to drop through a platform they're standing on
		if(move_grounded && move_grounded_instance != noone){
			if(move_grounded_instance.drop_through_enabled){
				// Check for down input
				if(input_current[UserControl.down]){
					// Track this platform instance to ignore for collision
					move_drop_through_instance = move_grounded_instance;
					
					// Force player to no longer be grounded
					move_grounded = false;
					move_grounded_instance = noone;
					
					//Mov Downward
					y += 10;
					transform_set(transform[TransformType.anchor],TransformValue.y,10,true);
				}
			}
		}
	#endregion
	
	//Float Countdown
	if(float_countdown <= 0){
		//Go to Move State
		state = PlayerState.move;
	}
	else{
		float_countdown -= global.delta_time_factor_scaled;
	}
	
	//Face
	character_face(false);
	
	//Dash
	character_dash();
	
	#region Out of Room
		if((x < 0) || (x > room_width) || (y < 0) || (y > room_height)){
			character_kill();
		}
	#endregion
	
	//Collision Situations
	player_collisions();
	
	//Movement Update
	player_movement_update();
}

/// @function player_gamestate_play
/// @summary Main state machine for player objects during gameplay.
function player_gamestate_play(){
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
		
		//Spring
		if(spring_countdown > 0){
			spring_countdown -= _delta_time_scaled;
		}
		
		//Jump Hold Allow  
		if(jump_hold_allow_countdown > 0){
			jump_hold_allow_countdown -= _delta_time_scaled;
		}
	#endregion

	//State Switch
	switch(state){
		case PlayerState.create:
			player_state_create();
		break;

		case PlayerState.idle:
			player_state_idle();
		break;

		case PlayerState.move:
			player_state_move();
		break;

		case PlayerState.dash:
			player_state_dash();
		break;
		
		case PlayerState.float:
			player_state_float();
		break;
		
		case PlayerState.hit:
			player_state_hit();
		break;

		case PlayerState.death:
			player_state_death();
		break;

		case PlayerState.destroy:
			player_state_destroy();
		break;
	}

	//Status Effects
	status_effect_system_update();
	
	#region Bump
		if(bump_allow){
			//No Bump Triggered Yet for This Dash
			if(!bump_triggered){
				var _bump,_bump_acceleration,_bump_acceleration_direction,_bump_acceleration_direction_additional,_bump_dash_direction,_bump_text_poster_distance,_bump_text_poster_x,_bump_text_poster_y;
				_bump = false;
				_bump_acceleration = 100;
				_bump_acceleration_direction = 0;
				_bump_acceleration_direction_additional = 45;
				_bump_dash_direction = 0;
				_bump_text_poster_distance = 200;
				_bump_text_poster_x = x;
				_bump_text_poster_y = y;
				
				var _platform_crumble_dash_collision;
				_platform_crumble_dash_collision = false;
				with(move_collision_object_instance){
					if(object_index == o_platform_crumble_dash){
						_platform_crumble_dash_collision = true;
						_bump_acceleration = 150;
						_bump_acceleration_direction_additional = 15;
						
						if(!crumble_trigger_active){
							crumble_trigger_active = true;
								
							if(crumble_trigger_active_instant){
								crumble_platform_state_crumble_active();
							}
						}
					}
				}
				
				if(collision.x == 1){
					_bump = true;
					if(!_platform_crumble_dash_collision){
						_bump_acceleration_direction = 180 - _bump_acceleration_direction_additional;
						_bump_dash_direction = 180;
					}
					else{
						_bump_acceleration_direction = 0 + _bump_acceleration_direction_additional;
						_bump_dash_direction = 0;
					}
					_bump_text_poster_x += _bump_text_poster_distance;
				}
				else if(collision.x == -1){
					_bump = true;
					if(!_platform_crumble_dash_collision){
						_bump_acceleration_direction = 0 + _bump_acceleration_direction_additional;
						_bump_dash_direction = 0;
					}
					else{
						_bump_acceleration_direction = 180 - _bump_acceleration_direction_additional;
						_bump_dash_direction = 180;
					}
					_bump_text_poster_x -= _bump_text_poster_distance;
				}
		
				if(collision.y == 1){
					_bump = true;
					if(!_platform_crumble_dash_collision){
						_bump_acceleration_direction = 90;
						_bump_dash_direction = 0;
					}
					else{
						_bump_acceleration_direction = input_move_direction;
						_bump_dash_direction = 0;
					}
					_bump_text_poster_y += _bump_text_poster_distance;
				}
				else if(collision.y == -1){
					_bump = true;
					if(!_platform_crumble_dash_collision){
						_bump_acceleration_direction = input_move_direction;
						_bump_dash_direction = 0;
					}
					else{
						_bump_acceleration_direction = 90;
						_bump_dash_direction = 0;
					}
					_bump_text_poster_y -= _bump_text_poster_distance;
				}
		
				//Bump Happened
				if(_bump){
					//Trigger Bump
					bump_triggered = true;
				
					//Give Bump Jump
					bump_jump_count++;
				
					//Refill Dash Stamina
					dash_stamina = dash_stamina_max;
					dash_stamina_depleted = false;
				
					//Reset Float Countdown
					float_countdown = float_countdown_max;
				
					//End Current Dash
					dash_countdown = 0;
					dash_hold_check_countdown = 0;
				
					//Bounce Acceleration
					acceleration.AddMagnitudeDirection(_bump_acceleration,_bump_acceleration_direction);
				
					//Update Dash No Input Direction
					dash_no_input_direction = _bump_dash_direction;
					
						//Bump Sprite
						image_system_setup(sprite_bump,ANIMATION_FPS_DEFAULT,true,false,0,IMAGE_LOOP_FULL);
						
							if(quick_smoke_fx_enable){
								// Bump impact FX (wall bumps only)
								if (collision.x == 1) {
									fx_spawn_sprite_once(bbox_right, y, "lyr_pfx_foreground", spr_smoke_bump_impact, -1, 1, 0, ANIMATION_FPS_DEFAULT);
								}
								else if (collision.x == -1) {
									fx_spawn_sprite_once(bbox_left, y, "lyr_pfx_foreground", spr_smoke_bump_impact, 1, 1, 0, ANIMATION_FPS_DEFAULT);
								}
							}
					
						if(_platform_crumble_dash_collision){
							//Camera Shake
							camera_shake_add(0.3,700,10,7,false,false,true,1.5,,false,100,);
					
						//Freeze Frame
						game_freeze(1);
						//master_time_scale_effect_slow(0.2,SECOND * 0.1);
					}
					else{
						//Camera Shake
						camera_shake_add(0.2,500,10,5,false,false,true,1,,false,100,);
					
						//Freeze Frame
						game_freeze(1);
						//master_time_scale_effect_slow(0.2,SECOND * 0.1);
					}
			
					//Text Poster
					with(instance_create_layer(_bump_text_poster_x,_bump_text_poster_y,"lyr_pfx_foreground",o_txtPstr_bump)){
						if(_platform_crumble_dash_collision)
							text_string = "SMASH!";
					}
				}
			}
		}
	#endregion
	
	//Image Update
	image_system_update();

	//Transform Update
	transform_system_update();

	//PFX System Execute
	//pfx_system_execute();
}

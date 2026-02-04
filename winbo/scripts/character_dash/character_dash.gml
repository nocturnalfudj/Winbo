/// @function character_dash
/// @summary Update dash cooldowns and stamina regeneration.
/// @returns {void} No return value.
function character_dash(){
	var _delta_time_factor_scaled;
	_delta_time_factor_scaled = global.delta_time_factor_scaled;
	
	#region Dash Cooldown
		if(dash_cooldown > 0){
			dash_cooldown -= _delta_time_factor_scaled;
		}
	#endregion
	
	#region Stamina Recovery
		if(dash_stamina < dash_stamina_max){
			//Slightly Faster Recovery During Depleted State
			if(dash_stamina_depleted){
				dash_stamina += dash_stamina_recovery_rate * _delta_time_factor_scaled * 1.5;
			}
			//Normal Recovery During Non Depleted
			else{
				dash_stamina += dash_stamina_recovery_rate * _delta_time_factor_scaled;
			}
		}
		
		//Dash Stamina Has Reached Max
		if((dash_stamina >= dash_stamina_max) && (dash_icon_animation_target != 0)){
			//Limit
			dash_stamina = dash_stamina_max;
				
			//No Longer Depleted
			dash_stamina_depleted = false;
				
			//Hide Dash Icon
			dash_icon_animation_start = dash_icon_scale;
			dash_icon_animation_target = 0;
			dash_icon_animation_time_current = 0;
				
			//Flash Dash Icon
			dash_icon_flash_alpha = 1;
			dash_icon_flash_colour = c_white;
			dash_icon_flash_lerp_val = 0.15;
		}
	#endregion
	
	//Dash
	if((!move_grounded) && (dash_enable) && (input_current[UserControl.dash]) && (!input_previous[UserControl.dash]) && (camera_visible)){
		if((!dash_stamina_depleted) && (dash_cooldown <= 0) && (dash_stamina >= dash_stamina_cost)){
			//Go to Dash State
			state = dash_state;
		
			//Start Dash Countdown
			dash_countdown = dash_countdown_max;
		
			//Set Dash Cooldown
			dash_cooldown = dash_cooldown_max;
		
			//Deduct Stamina Cost
			dash_stamina -= dash_stamina_cost;
		
			//No More Dashes Available - Depleted
			if(dash_stamina < dash_stamina_cost){
				dash_stamina_depleted = true;
			
				//Show Dash Icon
				dash_icon_animation_start = dash_icon_scale;
				dash_icon_animation_target = 1;
				dash_icon_animation_time_current = 0;
			}
			
			//Reset Dash Hold Countdowns
			dash_hold_check_countdown = dash_hold_check_countdown_max;
			dash_hold_allow_countdown = dash_hold_allow_countdown_max;
		
			//Reset Acceleration
			//velocity.Set(0,0);
			velocity.MultiplyFactor(0.5);
			acceleration.Set(0,0);
		
			//Adjust Velocity Retention & Max Acceleration
			velocity_retention = dash_velocity_retention;
			//movement_acceleration_max_set(dash_acceleration);
			
			//No Input Direction
			if(input_move_magnitude = 0){
				input_move_direction = dash_no_input_direction;
			}
		
			//Enable Speed Stretch
			speed_stretch_enable = true;
		
			//Player
			if(is_player){
				//Start Invincible
				//status_effect_start(StatusEffect.invincible_dash,0.6*SECOND);
				
				//Reset Bump
				bump_triggered = false;
				bump_jump_count = 0;
				bump_allow = true;
				bump_allow_countdown = bump_allow_countdown_max;
				
				//Dash Sprite
				image_system_setup(sprite_dash,ANIMATION_FPS_DEFAULT,true,false,0,IMAGE_LOOP_FULL);
			}
		
			#region Effects
				if(team != Team.enemy){
					//Camera Shake
					camera_shake(0.1*SECOND,2);
	
					//Zoom Out
					//with(o_camera){
					//	var _zoom_crnt,_zoom_targ,_zoom_max;
					//	_zoom_crnt = zoom_relative.current;
					//	_zoom_max = 1.6;
					//	if(_zoom_crnt < _zoom_max){
					//		_zoom_targ = _zoom_crnt + 0.025;
					//	}
					//	else{
					//		_zoom_crnt = _zoom_max - 0.01;
					//		_zoom_targ = _zoom_max;
					//	}
			
					//	transform_value_animate_from_current(zoom_relative,_zoom_targ,0,0.11*SECOND,ease_quad_out,true);
					//}
	
					//Game Freeze
					game_freeze(1);
					//master_time_scale_effect_slow(0.2,SECOND * 0.1);
				}
			#endregion
		}
		else{
			//Flash Dash Icon
			dash_icon_flash_alpha = 1;
			dash_icon_flash_colour = c_red;
			dash_icon_flash_lerp_val = 0.3;
		}
	}
	
	#region Icon
		if(dash_icon_enable){
			//Scale Animation
			if(dash_icon_scale != dash_icon_animation_target){
				//Animation Time
				if(dash_icon_animation_time_current < dash_icon_animation_time_max){
					dash_icon_animation_time_current += global.delta_time_factor;
				
					if(dash_icon_animation_time_current >= dash_icon_animation_time_max){
						dash_icon_animation_time_current = dash_icon_animation_time_max;
					}
				}
				
				//Update Scale
				if(dash_icon_animation_target == 1)
					dash_icon_scale  = ease_back_out(dash_icon_animation_start,dash_icon_animation_target,false,dash_icon_animation_time_current,dash_icon_animation_time_max);
				else
					dash_icon_scale  = ease_back_in(dash_icon_animation_start,dash_icon_animation_target,false,dash_icon_animation_time_current,dash_icon_animation_time_max);
			}
			
			//Light
			if(dash_icon_scale > 0){
				//Move Effect Values
				var _move_effect_x,_move_effect_y;
				_move_effect_x = move_effects_scale.x;
				_move_effect_y = move_effects_scale.y;
	
				//Scale Variables
				var _scale_x,_scale_y;
				_scale_x = image_xscale * _move_effect_x;
				_scale_y = image_yscale * _move_effect_y;
					
				var _dash_scale_x,_dash_scale_y,_dash_alpha;
				_dash_scale_x = _scale_x * dash_icon_scale;
				_dash_scale_y = _scale_y * dash_icon_scale;
				_dash_alpha = min(1,image_alpha * dash_icon_scale);
		
				var _x,_y;
				_x = (dash_icon_x + dash_icon_width/2) * _dash_scale_x;
				_y = (dash_icon_y + dash_icon_height/2) * _dash_scale_y;
					
				//Update Tracking Light
				with(dash_icon_light){
					offset_alpha	= _dash_alpha;
					offset_x		= _x;
					offset_y		= _y;
					offset_xscale	= _dash_scale_x * 0.5;
					offset_yscale	= _dash_scale_y * 0.5;
				}
			}
			
			//Flash
			if(dash_icon_flash_alpha != dash_icon_flash_alpha_target){
				dash_icon_flash_alpha = lerp(dash_icon_flash_alpha,dash_icon_flash_alpha_target,0.15);
			}
		}
	#endregion
}
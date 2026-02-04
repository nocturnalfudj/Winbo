function enemy_state_attack_active(){
	//Update Health
	character_health();
	
	//Detla Time Factor
	var _delta_time;
	if(time_scale_enable)
		_delta_time = global.delta_time_factor_scaled;
	else
		_delta_time = global.delta_time_factor;
	
	#region Movement (3x speed during active attack)
		var _attack_move_direction;
		_attack_move_direction = (face_horizontal == 1) ? 0 : 180;
		acceleration.AddMagnitudeDirection(INPUT_MOVE_ACCELERATION * 5, _attack_move_direction);
	#endregion
	
	#region Combat
		//Reset Countdown
		attack_countdown = attack_countdown_max;
		
		// Ranged: create once on entering active
		if(attack_type == AttackType.ranged){
			//Attack Needs to Be Created
			if(!attack_active_attack_created){
				#region Create Bullet
						var _target_x,_target_y;
						_target_x = target[TargetType.attack].x;
						_target_y = target[TargetType.attack].y;
						var _direction_to_player;
						if(_target_x > x){
							if(_target_y < (y - 300)){
								_direction_to_player = 45;
							}
							else{
								if(attack_ranged_can_aim_downward){
									if(_target_y > (y + 300)){
										_direction_to_player = -45;
									}
									else{
										_direction_to_player = 0;
									}
								}
								else{
									_direction_to_player = 0;
								}
							}
						}
						else{
							if(_target_y < (y - 300)){
								_direction_to_player = 135;
							}
							else{
								if(attack_ranged_can_aim_downward){
									if(_target_y > (y + 300)){
										_direction_to_player = -135;
									}
									else{
										_direction_to_player = 180;
									}
								}
								else{
									_direction_to_player = 180;
								}
							}
						}
				
						var _bullet_instance;
						_bullet_instance = instance_create_layer(x,y,"lyr_player",o_bullet);
						with(_bullet_instance){
							//Set Enemy Team
							team = other.team;
						
							//Accelerate Towards Player
							acceleration.AddMagnitudeDirection(other.attack_ranged_bullet_acceleration,_direction_to_player);
						}
			}
			
				//Attack Created
				attack_active_attack_created = true;
			#endregion
		}
		// Melee: spawn/destroy within the configured frame window (or legacy behaviour if disabled)
		else if(attack_type == AttackType.melee){
			var _want_hitbox;
			_want_hitbox = true;
			
			if(attack_melee_active_frames_enable){
				_want_hitbox = (sprite_current_frame >= attack_melee_active_frame_start) && (sprite_current_frame <= attack_melee_active_frame_end);
			}
			
			// Legacy behaviour: create once for the whole active state if frame-window is disabled.
			if(!attack_melee_active_frames_enable){
				_want_hitbox = true;
			}
			
			// Spawn if needed and not currently present
			if(_want_hitbox){
				if(!instance_exists(attack_melee_attack_instance)){
					attack_melee_attack_instance = instance_create_depth(x,y,depth-1,o_melee_attack);
					attack_melee_attack_instance.owner = id;
					attack_melee_attack_instance.team = team;
					
					// Use the configured sprite for collisions AND drawing.
					// Note: o_melee_attack inherits o_prop, which draws sprite_current/sprite_current_frame.
					with(attack_melee_attack_instance){
						image_system_setup(other.attack_melee_collision_mask_sprite, ANIMATION_FPS_DEFAULT * other.animation_fps_multiplier, false, false, 0, IMAGE_LOOP_FULL);
						image_set_frame(image, 0);
						mask_index = other.attack_melee_collision_mask_sprite;
						
						// Match owner scale magnitude, and flip based on facing direction.
						// Commando uses directional sprites (no xscale flip), so we must apply facing here.
						image_xscale = abs(other.image_xscale) * other.face_horizontal;
						image_yscale = abs(other.image_yscale);
					}
				}
			}
			// Destroy if not needed but currently present
			else{
				if(instance_exists(attack_melee_attack_instance)){
					with(attack_melee_attack_instance){
						instance_destroy();
					}
					attack_melee_attack_instance = noone;
				}
			}
		}
	
		//Run Active Countdown
		if(attack_active_countdown > 0){
			attack_active_countdown -= _delta_time;
		}
		
		var _trigger_recover;
		_trigger_recover = false;
		
		//Frame-based progression
		if(attack_active_progress_at_frame_enable){
			if(sprite_current_frame >= attack_active_progress_at_frame){
				_trigger_recover = true;
			}
		}
		//Progress When Animation Finishes
		else if(attack_active_progress_at_end_of_animation){
			//Animation Finished
			if(sprite_current_frame >= (image.sprite_number - 1)){
				_trigger_recover = true;
			}
		}
		else if(attack_active_countdown <= 0){
			_trigger_recover = true;
		}
		
		//Trigger Recover
		if(_trigger_recover){
			//Destroy Any Melee Attack
			with(attack_melee_attack_instance){
				instance_destroy();
			}
			
			//Go to Attack Recover State
			state = EnemyState.attack_recover;
			
			//Update Sprite (unless using combined sprite)
			if(!attack_recover_skip_sprite_change){
				image_system_setup(sprite_attack_recover,ANIMATION_FPS_DEFAULT * animation_fps_multiplier,true,true,0,IMAGE_LOOP_FULL);
			}
		}
	#endregion
	
	#region Out of Room
		if((x < 0) || (x > room_width) || (y < 0) || (y > room_height)){
			character_kill();
		}
	#endregion
}
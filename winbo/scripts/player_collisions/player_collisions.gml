function player_collisions(){
	#region Collisions
		#region Hazard
			var _hazard_collision_instance;
			_hazard_collision_instance = instance_place(x,y,o_hazard);
			with(_hazard_collision_instance){
				//Instant Kill
				if(instant_kill){
					with(other){
						//Set HP to 0
						hp = 0;
						user.hp = 0;
						
						//Kill Player
						character_kill();
					}
				}
				//Normal Hit
				else{
					with(other){
						player_hit(other.damage_amount);
					}
				}
			}
		#endregion
				
		#region Bullet
			var _bullet_collision_instance;
			_bullet_collision_instance = instance_place(x,y,o_bullet);
			with(_bullet_collision_instance){
				//Ignore if Same Team
				if(team == other.team)
					break;

				//Ignore if Bullet is Dead
				if((state == BulletState.death) || (state == BulletState.destroy))
					break;

				// Check if player is dashing/recently dashed - deflect bullet instead of damage
				// Uses bump_allow for 0.1s leniency window (same as wall bumps)
				if(other.bump_allow){
					// Bullet destroyed (no damage to player)
					state = BulletState.death;

					// Trigger bump bounce if not already triggered this dash
					if(!other.bump_triggered){
						with(other){
							// Calculate bounce direction away from bullet
							var _bump_dir = point_direction(_bullet_collision_instance.x, _bullet_collision_instance.y, x, y);
							var _bump_acceleration = 100;

							// Trigger bump
							bump_triggered = true;
							bump_jump_count++;

							// Refill dash stamina
							dash_stamina = dash_stamina_max;
							dash_stamina_depleted = false;

							// Reset float countdown
							float_countdown = float_countdown_max;

							// End current dash
							dash_countdown = 0;
							dash_hold_check_countdown = 0;

							// Apply bounce acceleration
							acceleration.AddMagnitudeDirection(_bump_acceleration, _bump_dir);

							// Update dash no input direction for follow-up dash
							dash_no_input_direction = _bump_dir;

							// Bump sprite
							image_system_setup(sprite_bump, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);

							// Camera shake
							camera_shake_add(0.2, 500, 10, 5, false, false, true, 1,, false, 100,);

							// Freeze frame
							game_freeze(1);

							// Text poster
							with(instance_create_layer(x, y - 100, "lyr_pfx_foreground", o_txtPstr_bump)){
								text_string = "DEFLECT!";
							}
						}
					}
				}
				else{
					// Normal damage - hit player and destroy bullet
					with(other){
						player_hit();
					}
					state = BulletState.death;
				}
			}
		#endregion
				
		#region Melee Attack
			var _melee_attack_collision_instance;
			_melee_attack_collision_instance = instance_place(x,y,o_melee_attack);
			with(_melee_attack_collision_instance){
				//Ignore if Same Team
				if(team == other.team)
					break;
						
				//Ignore if Already Hit Player
				if(hit_player)
					break;
							
				//Kill Player
				with(other){
					player_hit();
				}
			}
		#endregion
				
		#region Enemy
			var _enemy_collision_instance;
			_enemy_collision_instance = instance_place(x,y,o_enemy);
			with(_enemy_collision_instance){
				//Ignore if Enemy is Dead
				if((state == EnemyState.death) || (state == EnemyState.destroy))
					break;
						
				//Enemy Top Was Below Player Last Frame
				if(bbox_top > other.yprevious){
					character_kill();
					
					// Track enemy defeat by type
					if(object_is_ancestor(object_index, o_enemy_melee_parent)){
						level_stat_add(LevelStat.enemies_defeated_melee);
					}
					else if(object_is_ancestor(object_index, o_enemy_ranged_flying_parent)){
						level_stat_add(LevelStat.enemies_defeated_flying);
					}
					else if(object_is_ancestor(object_index, o_enemy_ranged_parent)){
						level_stat_add(LevelStat.enemies_defeated_ranged);
					}
					
					//Flash
					flash_alpha = 1;
							
					//Bounce Player
					with(other){
						acceleration.Set(0,0);
						velocity.Set(0,0);
								
						acceleration.AddMagnitudeDirection(input_move_acceleration_jump/2,90);
								
						//Start with Rise Gravity
						move_gravity.Copy(move_gravity_rise);
						
						//Refill Dash Stamina
						dash_stamina = dash_stamina_max;
						dash_stamina_depleted = false;
					}
				}
				//Contact Damage - player takes damage from touching enemies (not stomping)
				else{
					with(other){
						player_hit();
					}
				}
			}
		#endregion
				
		#region Checkpoints
			var _checkpoint_collision_instance;
			_checkpoint_collision_instance = instance_place(x,y,o_checkpoint);
			with(_checkpoint_collision_instance){
				//Ignore if Already Active
				if(checkpoint_active)
					continue;
						
				//Deactivate Other Checkpoints
				with(o_checkpoint){
					//Other Checkpoint
					if(id == _checkpoint_collision_instance)
						continue;
							
					//Checkpoint
					checkpoint_active = false;
							
					//Decativation Animation
					image_system_setup(sprite_idle,ANIMATION_FPS_DEFAULT,true,true,0,IMAGE_LOOP_FULL);
					sprite_current_frame = 0;
					//transform_animate_from_current(transform[TransformType.anchor],TransformValue.colour,c_ltgray,0,SECOND * 0.2,ease_quad_out);
					//transform_animate_from_current(transform[TransformType.anchor],TransformValue.xscale,0.8,0,SECOND * 0.2,ease_quad_out);
					//transform_animate_from_current(transform[TransformType.anchor],TransformValue.yscale,0.8,0,SECOND * 0.2,ease_quad_out);
					//transform_animate_from_current(transform[TransformType.anchor],TransformValue.alpha,0.8,0,SECOND * 0.2,ease_quad_out);
					//transform_animate_from_current_relative_to_rest(transform[TransformType.anchor],TransformValue.y,0,0,SECOND * 0.2,ease_quad_out);
				}
						
				//Activate
				checkpoint_active = true;
				image_system_setup(sprite_jump,ANIMATION_FPS_DEFAULT,true,true,16,IMAGE_LOOP_FULL);
				sprite_current_frame = 0;
				//transform_animate_from_current(transform[TransformType.anchor],TransformValue.colour,c_white,0,SECOND * 0.2,ease_quad_out);
				//transform_animate_from_current(transform[TransformType.anchor],TransformValue.xscale,1,0,SECOND * 0.2,ease_back_out);
				//transform_animate_from_current(transform[TransformType.anchor],TransformValue.yscale,1,0,SECOND * 0.2,ease_back_out);
				//transform_animate_from_current(transform[TransformType.anchor],TransformValue.alpha,1,0,SECOND * 0.2,ease_quad_out);
				//transform_animate_from_current_relative_to_rest(transform[TransformType.anchor],TransformValue.y,-100,0,SECOND * 0.2,ease_back_out);
						
				//Text Poster
				with(instance_create_layer(x,y - 350,"lyr_pfx_foreground",o_txtPstr_bump)){
					text_string = "CHECKPOINT!";
				}
			}
		#endregion
				
	#region Spring
		var _spring_collision_instance;
		_spring_collision_instance = instance_place(x,y,o_spring);
		// Trigger for o_spring or o_spring_vertical, but NOT o_spring_horizontal
		if((_spring_collision_instance != noone) && (_spring_collision_instance.object_index != o_spring_horizontal) && (spring_countdown <= 0) && (velocity.y > 0)){
			//Reset Countdown
			spring_countdown = SPRING_COUNTDOWN_MAX;
					
			//Bounce Acceleration
			acceleration.Set(0,0);
			velocity.Set(0,0);
			acceleration.AddMagnitudeDirection(_spring_collision_instance.spring_acceleration * input_move_acceleration_jump,_spring_collision_instance.spring_direction);
						
			//Start with Rise Gravity
			move_gravity.Copy(move_gravity_rise);
			
			//Refill Dash Stamina
			dash_stamina = dash_stamina_max;
			dash_stamina_depleted = false;
					
			//Spring Animation
			with(_spring_collision_instance){
				//Start Active Animation
				image_system_setup(sprite_active,ANIMATION_FPS_DEFAULT,true,false,0,IMAGE_LOOP_FULL);
			}
		}
	#endregion
	
	#region Spring Horizontal
		var _spring_horizontal_collision_instance;
		_spring_horizontal_collision_instance = instance_place(x,y,o_spring_horizontal);
		if((_spring_horizontal_collision_instance != noone) && (spring_countdown <= 0) && (abs(velocity.x) > 0.1)){
			// Determine bounce direction based on velocity
			// Moving right bounces left, moving left bounces right (opposite direction)
			var _bounce_direction;
			if(velocity.x > 0){
				_bounce_direction = 180; // Moving right, bounce left (opposite)
			}
			else{
				_bounce_direction = 0; // Moving left, bounce right (opposite)
			}
			
			//Reset Countdown
			spring_countdown = SPRING_COUNTDOWN_MAX;
					
			//Bounce Acceleration
			// Reset horizontal velocity/acceleration
			velocity.x = 0;
			acceleration.x = 0;
			
			// Only reset downward Y velocity/acceleration (preserve upward momentum)
			if(velocity.y > 0){
				velocity.y = 0;
				acceleration.y = 0;
			}
			
			// Apply horizontal bounce acceleration (doubled for stronger bounce)
			acceleration.AddMagnitudeDirection(_spring_horizontal_collision_instance.spring_acceleration * input_move_acceleration_jump * 1.2, _bounce_direction);
					
			//Start with Rise Gravity (same as vertical spring)
			move_gravity.Copy(move_gravity_rise);
			
			//Refill Dash Stamina
			dash_stamina = dash_stamina_max;
			dash_stamina_depleted = false;
					
			//Spring Animation
			with(_spring_horizontal_collision_instance){
				//Start Active Animation
				image_system_setup(sprite_active,ANIMATION_FPS_DEFAULT,true,false,0,IMAGE_LOOP_FULL);
			}
		}
	#endregion
			
		#region Pickups
			var _pickup_collision_instance;
			_pickup_collision_instance = instance_place(x,y,o_pickup);
			with(_pickup_collision_instance){
				if(state == PickupState.idle){
					state = PickupState.collect;
				}
			}
		#endregion
			
		#region Door
			var _door_collision_instance;
			_door_collision_instance = instance_place(x,y,o_door);
			with(_door_collision_instance){
			// Skip bonus doors - they handle their own input-based transitions
			if(bonus_door_enable){
				break;
			}
			
			// Check if this is a level end character door
			if(level_end_character_enable){
				// Only trigger if player is grounded
				if(other.move_grounded){
					// Only trigger once
					if(!level_end_character_triggered){
						level_end_character_triggered = true;
						
						// Trigger level end flash sequence
						game_state_set_target(GameState.level_end_flash);
						
						// Reset flash countdown for this level end
						with(o_master){
							level_end_flash_countdown.Reset();
						}
					}
				}
			}
				else{
					// Normal door behavior - immediate room transition
					//Check if In Presence Room
					if(room == r_game_level_presence){
						room_goto(o_director.next_level);
					}
					//In Level Room
					else{
						//Update Director Next Level
						o_director.next_level = room_target;
								
						//Go to Presence Room
						room_goto(r_game_level_presence);
					}
							
					//Reset Level Timer
					o_director.level_timer = 0;
				}
			}
		#endregion
				
		#region Liquids
			//Default to Gravity Factor of 1
			move_gravity_factor = 1;
					
			//Previous
			var _liquid_collision_instance_previous;
			_liquid_collision_instance_previous = liquid_collision_instance;
					
			//Update Gravity Factor Whilst In Liquid
			var _liquid_collision_instance;
			_liquid_collision_instance = instance_position(x,y+height/2,o_volume_liquid);
			with(_liquid_collision_instance){
				other.move_gravity_factor = gravity_factor;
						
				//New Liquid Collision
				if(_liquid_collision_instance_previous != _liquid_collision_instance){
					liquid_impulse(other.x - other.width/4,other.y,3,128,true);
				}
			}
			liquid_collision_instance = _liquid_collision_instance;
					
			//Leaving a Liquid
			if((_liquid_collision_instance_previous != noone) && (liquid_collision_instance == noone)){
				with(_liquid_collision_instance_previous){
					liquid_impulse(other.x - other.width/4,other.y,3,128,false);
				}
			}
		#endregion
	#endregion
			
	#region Landed on Crumble Platform
		if(move_grounded_instance != noone){
			with(move_grounded_instance){
				if(object_index == o_platform_crumble){
					if(!crumble_trigger_active){
						crumble_trigger_active = true;
								
						if(crumble_trigger_active_instant){
							crumble_platform_state_crumble_active();
						}
					}
				}
			}
		}
	#endregion
}
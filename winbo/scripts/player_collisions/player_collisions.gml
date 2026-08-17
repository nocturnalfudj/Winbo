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
						player_hit(other.damage_amount, other, true);
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
				if(other.bump_allow && deflect_enable){
					if(deflect_flyoff_enable){
						var _flyoff_direction = point_direction(other.x, other.y, x, y);
						bullet_begin_deflect_flyoff(_flyoff_direction);
					}
					else{
						if(death_anim_suppress_on_deflect){
							death_anim_suppressed = true;
						}
						
						// Bullet destroyed (no damage to player)
						state = BulletState.death;
					}

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
						player_hit(1, other, false);
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
					player_hit(1, other, true);
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

				if((other.state == PlayerState.dive_spring) && (other.dive_spring_phase == DiveSpringPhase.dive)){
					death_smoke_enable = true;
					death_smoke_spawned = false;
					death_smoke_step_count = 0;

					character_kill();

					if(object_is_ancestor(object_index, o_enemy_melee_parent)){
						level_stat_add(LevelStat.enemies_defeated_melee);
					}
					else if(object_is_ancestor(object_index, o_enemy_ranged_flying_parent)){
						level_stat_add(LevelStat.enemies_defeated_flying);
					}
					else if(object_is_ancestor(object_index, o_enemy_ranged_parent)){
						level_stat_add(LevelStat.enemies_defeated_ranged);
					}

					flash_alpha = 1;

					with(other){
						player_dive_spring_register_impact();
					}

					break;
				}
						
				//Enemy Top Was Below Player Last Frame
				if(bbox_top > other.yprevious){
					// Winbo stomp-kill: spawn the large smoke explosion a couple frames into death state.
					death_smoke_enable = true;
					death_smoke_spawned = false;
					death_smoke_step_count = 0;
					
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
								
						acceleration.AddMagnitudeDirection(input_move_acceleration_jump * enemy_bounce_acceleration_factor,90);
								
						//Start with Rise Gravity
						move_gravity.Copy(move_gravity_rise);

						player_air_spin_start();
						
						//Refill Dash Stamina
						dash_stamina = dash_stamina_max;
						dash_stamina_depleted = false;
					}
				}
				//Contact Damage - player takes damage from touching enemies (not stomping)
				else{
					with(other){
					player_hit(1, other, false);
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
				audio_checkpoint_activate_play();
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
		if((_spring_collision_instance == noone) && (move_grounded_instance != noone)){
			if((move_grounded_instance.object_index == o_spring)
			|| object_is_ancestor(move_grounded_instance.object_index, o_spring)){
				_spring_collision_instance = move_grounded_instance;
			}
		}
		if(_spring_collision_instance == noone){
			_spring_collision_instance = instance_place(x, y + 10, o_spring);
		}
		var _spring_sweep_y;
		_spring_sweep_y = y - yprevious;
		if((_spring_collision_instance == noone) && (_spring_sweep_y > 0)){
			_spring_collision_instance = collision_rectangle(
				bbox_left,
				bbox_top - _spring_sweep_y,
				bbox_right,
				bbox_bottom,
				o_spring,
				false,
				true
			);
		}

		if((_spring_collision_instance != noone)
		&& (_spring_collision_instance.object_index != o_spring_horizontal)
		&& (spring_countdown <= 0)){
			var _spring_top_contact;
			var _spring_previous_bottom;
			_spring_previous_bottom = bbox_bottom - _spring_sweep_y;
			_spring_top_contact = (move_grounded_instance == _spring_collision_instance)
				|| ((_spring_previous_bottom <= (_spring_collision_instance.bbox_top + 4))
					&& (bbox_bottom >= _spring_collision_instance.bbox_top)
					&& (velocity.y >= 0));

			if(_spring_top_contact){
				player_mushroom_bounce(_spring_collision_instance);
			}
		}
	#endregion
	
	#region Spring Horizontal
		var _spring_horizontal_collision_instance;
		_spring_horizontal_collision_instance = instance_place(x,y,o_spring_horizontal);
		var _spring_horizontal_direct_contact;
		_spring_horizontal_direct_contact = _spring_horizontal_collision_instance != noone;
		if((_spring_horizontal_collision_instance == noone) && (move_grounded_instance != noone)){
			if((move_grounded_instance.object_index == o_spring_horizontal)
			|| object_is_ancestor(move_grounded_instance.object_index, o_spring_horizontal)){
				_spring_horizontal_collision_instance = move_grounded_instance;
			}
		}
		if(_spring_horizontal_collision_instance == noone){
			_spring_horizontal_collision_instance = instance_place(x, y + 10, o_spring_horizontal);
		}
		var _spring_horizontal_sweep_y;
		_spring_horizontal_sweep_y = y - yprevious;
		if((_spring_horizontal_collision_instance == noone) && (_spring_horizontal_sweep_y > 0)){
			_spring_horizontal_collision_instance = collision_rectangle(
				bbox_left,
				bbox_top - _spring_horizontal_sweep_y,
				bbox_right,
				bbox_bottom,
				o_spring_horizontal,
				false,
				true
			);
		}
		if((_spring_horizontal_collision_instance != noone) && (spring_countdown <= 0)){
			var _mushroom_top_contact;
			var _mushroom_previous_bottom;
			_mushroom_previous_bottom = bbox_bottom - _spring_horizontal_sweep_y;
			_mushroom_top_contact = (move_grounded_instance == _spring_horizontal_collision_instance)
				|| ((_mushroom_previous_bottom <= (_spring_horizontal_collision_instance.bbox_top + 4))
					&& (bbox_bottom >= _spring_horizontal_collision_instance.bbox_top)
					&& (velocity.y >= 0));

			if(_mushroom_top_contact){
				player_mushroom_bounce(_spring_horizontal_collision_instance);
			}
			else if(_spring_horizontal_direct_contact
			&& (state != PlayerState.dive_spring)
			&& (abs(velocity.x) > 0.1)){
				player_mushroom_side_bounce(_spring_horizontal_collision_instance);
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
					// Normal door behavior follows the campaign progression metadata.
						var _transition = level_select_build_transition(room);
						if (!is_undefined(_transition)) {
							level_select_apply_transition(_transition, false);
						}
						else{
							// Fallback for unregistered rooms.
							if(room == r_game_level_presence){
								director_gameplay_transition_request(
									o_director.next_level,
									director_gameplay_transition_options_build(
										o_director.next_level,
										true,
										true,
										false,
										GameState.play,
										PlayerSpawnContext.level_start
									)
								);
							}
							else{
								o_director.next_level = room_target;
								director_gameplay_transition_request(
									r_game_level_presence,
									director_gameplay_transition_options_build(
										r_game_level_presence,
										true,
										true,
										false,
										GameState.play,
										PlayerSpawnContext.presence_start
									)
								);
							}
						}
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
				if(((object_index == o_platform_crumble) || object_is_ancestor(object_index, o_platform_crumble))
				&& (crumble_trigger_type == PlatformCrumbleTrigger.touch)){
					if(!crumble_trigger_active){
						crumble_trigger_active = true;
						break_fx_blast_direction = noone;
								
						if(crumble_trigger_active_instant){
							crumble_platform_state_crumble_active();
						}
					}
				}
			}
		}
	#endregion
}

/// @function player_mushroom_collisions_post_movement
/// @summary Resolve mushroom contacts against the movement system's updated anchor transform.
function player_mushroom_collisions_post_movement(){
	var _spring_sweep_x, _spring_sweep_y;
	var _movement_transform, _position_x, _position_y;
	_movement_transform = transform[TransformType.anchor];
	_position_x = _movement_transform.value[TransformValue.x].current;
	_position_y = _movement_transform.value[TransformValue.y].current;
	_spring_sweep_x = _position_x - x;
	_spring_sweep_y = _position_y - y;
	if((_spring_sweep_x == 0) && (_spring_sweep_y == 0)){
		return;
	}

	// Movement writes the anchor transform first; the normal transform-system
	// pass does not copy it back to x/y until later in the player Step event.
	// Synchronize now so bbox values and the contact resolution use the actual
	// post-movement position.
	x = _position_x;
	y = _position_y;

	if(spring_countdown > 0){
		return;
	}

	// The movement solver stops just clear of a resolved collision. Find the
	// nearest actual downward-blocking surface at that final position instead
	// of trusting its unordered candidate id; overlapping solids can otherwise
	// leave a lower mushroom recorded as the collision owner.
	if((collision.y == 1) && (_spring_sweep_y > 0)){
		var _resolved_surface_candidates;
		_resolved_surface_candidates = ds_list_create();
		collision_rectangle_list(
			bbox_left,
			bbox_bottom,
			bbox_right,
			bbox_bottom + 4,
			move_collision_object,
			false,
			true,
			_resolved_surface_candidates,
			false
		);

		var _resolved_surface_distance, _resolved_mushroom;
		_resolved_surface_distance = 5;
		_resolved_mushroom = noone;
		for(var _surface_index = 0;
		_surface_index < ds_list_size(_resolved_surface_candidates);
		_surface_index++){
			var _surface;
			_surface = _resolved_surface_candidates[| _surface_index];
			var _surface_distance;
			_surface_distance = _surface.bbox_top - bbox_bottom;
			var _surface_blocks_down;
			_surface_blocks_down = _surface.collision_enable_y_in
				|| _surface.collision_enable_y_down;
			var _surface_is_mushroom;
			_surface_is_mushroom = (_surface.object_index == o_spring)
				|| object_is_ancestor(_surface.object_index, o_spring);

			if(_surface_blocks_down
			&& (_surface_distance >= 0)
			&& ((_surface_distance < _resolved_surface_distance)
				|| ((_surface_distance == _resolved_surface_distance)
					&& _surface_is_mushroom))){
				_resolved_surface_distance = _surface_distance;
				_resolved_mushroom = _surface_is_mushroom ? _surface : noone;
			}
		}
		ds_list_destroy(_resolved_surface_candidates);

		if(_resolved_mushroom != noone){
			player_mushroom_bounce(_resolved_mushroom);
			return;
		}
	}

	var _previous_left, _previous_right, _previous_top, _previous_bottom;
	_previous_left = bbox_left - _spring_sweep_x;
	_previous_right = bbox_right - _spring_sweep_x;
	_previous_top = bbox_top - _spring_sweep_y;
	_previous_bottom = bbox_bottom - _spring_sweep_y;

	var _mushroom_candidates;
	_mushroom_candidates = ds_list_create();
	collision_rectangle_list(
		min(_previous_left, bbox_left),
		min(_previous_top, bbox_top),
		max(_previous_right, bbox_right),
		max(_previous_bottom, bbox_bottom),
		o_spring,
		false,
		true,
		_mushroom_candidates,
		false
	);

	var _contact_mushroom, _contact_type, _contact_fraction;
	_contact_mushroom = noone;
	_contact_type = 0;
	_contact_fraction = 2;

	for(var _candidate_index = 0; _candidate_index < ds_list_size(_mushroom_candidates); _candidate_index++){
		var _mushroom;
		_mushroom = _mushroom_candidates[| _candidate_index];

		// Test the exact horizontal span at the instant the feet cross the cap.
		// Using the full swept AABB alone would report false corner contacts.
		if((_spring_sweep_y > 0)
		&& (_previous_bottom <= (_mushroom.bbox_top + 4))
		&& (bbox_bottom >= _mushroom.bbox_top)){
			var _top_fraction, _left_at_top, _right_at_top;
			_top_fraction = clamp((_mushroom.bbox_top - _previous_bottom) / _spring_sweep_y, 0, 1);
			_left_at_top = _previous_left + (_spring_sweep_x * _top_fraction);
			_right_at_top = _previous_right + (_spring_sweep_x * _top_fraction);

			if((_right_at_top >= _mushroom.bbox_left)
			&& (_left_at_top <= _mushroom.bbox_right)
			&& (_top_fraction < _contact_fraction)){
				_contact_mushroom = _mushroom;
				_contact_type = 1;
				_contact_fraction = _top_fraction;
			}
		}

		var _horizontal_mushroom;
		_horizontal_mushroom = (_mushroom.object_index == o_spring_horizontal)
			|| object_is_ancestor(_mushroom.object_index, o_spring_horizontal);
		if(_horizontal_mushroom && (_spring_sweep_x != 0)){
			var _side_fraction;
			_side_fraction = -1;
			if((_spring_sweep_x > 0)
			&& (_previous_right <= _mushroom.bbox_left)
			&& (bbox_right >= _mushroom.bbox_left)){
				_side_fraction = (_mushroom.bbox_left - _previous_right) / _spring_sweep_x;
			}
			else if((_spring_sweep_x < 0)
			&& (_previous_left >= _mushroom.bbox_right)
			&& (bbox_left <= _mushroom.bbox_right)){
				_side_fraction = (_mushroom.bbox_right - _previous_left) / _spring_sweep_x;
			}

			if((_side_fraction >= 0)
			&& (_side_fraction <= 1)
			&& (_side_fraction < _contact_fraction)){
				var _top_at_side, _bottom_at_side;
				_top_at_side = _previous_top + (_spring_sweep_y * _side_fraction);
				_bottom_at_side = _previous_bottom + (_spring_sweep_y * _side_fraction);
				if((_bottom_at_side > _mushroom.bbox_top)
				&& (_top_at_side < _mushroom.bbox_bottom)){
					_contact_mushroom = _mushroom;
					_contact_type = 2;
					_contact_fraction = _side_fraction;
				}
			}
		}
	}

	ds_list_destroy(_mushroom_candidates);

	if(_contact_type == 1){
		player_mushroom_bounce(_contact_mushroom);
	}
	else if(_contact_type == 2){
		if(_spring_sweep_x > 0){
			x -= bbox_right - _contact_mushroom.bbox_left;
		}
		else{
			x += _contact_mushroom.bbox_right - bbox_left;
		}
		transform_set(transform[TransformType.anchor], TransformValue.x, x, false);
		player_mushroom_side_bounce(_contact_mushroom, sign(_spring_sweep_x));
	}
}

/// @function player_mushroom_bounce
/// @summary Bounce from the top of any mushroom, regardless of the current aerial state.
function player_mushroom_bounce(_mushroom){
	// A mushroom bounce always wins over Dive Spring: cancel the special state
	// before applying the standard vertical spring impulse.
	if(state == PlayerState.dive_spring){
		player_dive_spring_reset();
		state = PlayerState.move;
	}

	// Swept detection can catch a fast Dive Spring after the movement step has
	// crossed the mushroom top. Resolve that penetration before launching.
	if(bbox_bottom > _mushroom.bbox_top){
		y -= bbox_bottom - _mushroom.bbox_top;
		transform_set(transform[TransformType.anchor], TransformValue.y, y, false);
	}

	spring_countdown = SPRING_COUNTDOWN_MAX;
	move_grounded = false;
	move_grounded_instance = noone;
	move_grounded_close = false;
	move_grounded_close_instance = noone;
	velocity.Set(0, 0);
	acceleration.Set(0, 0);
	acceleration.AddMagnitudeDirection(_mushroom.spring_acceleration * input_move_acceleration_jump, 90);
	move_gravity.Copy(move_gravity_rise);
	player_air_spin_start();
	dash_stamina = dash_stamina_max;
	dash_stamina_depleted = false;
	float_countdown = float_countdown_max;

	with(_mushroom){
		image_system_setup(sprite_active, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
	}

}

/// @function player_mushroom_side_bounce
/// @summary Preserve the red wall mushroom's original horizontal ricochet.
function player_mushroom_side_bounce(_mushroom, _approach_direction = 0){
	if(state == PlayerState.dive_spring){
		player_dive_spring_reset();
		state = PlayerState.move;
	}

	var _bounce_direction;
	if(_approach_direction == 0){
		_approach_direction = sign(velocity.x);
	}
	_bounce_direction = (_approach_direction > 0) ? 180 : 0;

	spring_countdown = SPRING_COUNTDOWN_MAX;
	velocity.x = 0;
	acceleration.x = 0;
	if(velocity.y > 0){
		velocity.y = 0;
		acceleration.y = 0;
	}

	acceleration.AddMagnitudeDirection(_mushroom.spring_acceleration * input_move_acceleration_jump * 1.2, _bounce_direction);
	move_gravity.Copy(move_gravity_rise);
	dash_stamina = dash_stamina_max;
	dash_stamina_depleted = false;

	with(_mushroom){
		image_system_setup(sprite_active, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
	}
}

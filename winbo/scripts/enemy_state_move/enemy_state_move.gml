function enemy_state_move(){
	//Update Health
	character_health();

	// Track facing at start of step so we can detect direction changes even if we force face_horizontal earlier.
	var _face_horizontal_prev = face_horizontal;

	// Patrol loop counting: detect when the relaxed walk loop wraps back to start.
	// This relies on sprite_current_frame being updated by image_system_update() each step.
	if(!is_hostile && patrol_turn_after_walk_loops_enable && !image.is_playing_queued){
		// Only count when using the relaxed walk loop range (not idle loop)
		if(sprite_current != noone && sprite_current == enemy_sprite_get_directional(sprite_walk_relaxed_left, sprite_walk_relaxed_right)
		&& image.loop_start == walk_relaxed_walk_start){
			if(sprite_current_frame < patrol_walk_frame_prev && sprite_current_frame == walk_relaxed_walk_start){
				patrol_walk_loops_count += 1;
				if(patrol_walk_loops_count >= patrol_walk_loops_before_turn){
					patrol_walk_loops_count = 0;
					patrol_pending_turn = true;
				}
			}
		}
		patrol_walk_frame_prev = sprite_current_frame;
	}

	//Detection / Startled
		if((!is_hostile) && (hostility_detection_enable)){
			target_update(TargetType.attack);

			// Check both total distance AND vertical distance for aggro
			var _within_range = target[TargetType.attack].is_within_distance(hostility_detection_range);
			var _within_y_range = abs(target[TargetType.attack].y - y) <= hostility_detection_y_threshold;

			if(_within_range && _within_y_range){
				// Become hostile
				is_hostile = true;
				hostility_detection_enable = false;

				//Face player
				if(target[TargetType.attack].x > x){
					face_horizontal = 1;
				}
				else{
					face_horizontal = -1;
				}

				// Only play startled animation if it hasn't been played before
				if(!has_played_startled){
					has_played_startled = true;

					//Play startled
					var _startled_sprite;
					_startled_sprite = sprite_startled_left;
					if(sprite_direction_enable && (sprite_startled_left != noone) && (sprite_startled_right != noone)){
						_startled_sprite = enemy_sprite_get_directional(sprite_startled_left,sprite_startled_right);
					}

					if(_startled_sprite != noone){
						image_system_setup(_startled_sprite,ANIMATION_FPS_DEFAULT * animation_fps_multiplier,true,false,0,IMAGE_LOOP_FULL);
						if(sprite_startled_start_frame > 0){
							image_set_frame(image, sprite_startled_start_frame);
						}
					}

					state = EnemyState.startled;
					return;
				}
				else{
					// Re-aggro after de-aggro: allow immediate attack eligibility.
					attack_countdown = 0;
				}
			}
		}

	#region Input
		// If a queued animation (turn transition) is playing, don't apply movement this step.
		// This prevents the enemy from "sliding" while the turn-around animation plays.
		if(sprite_animation_extended_enable && image.is_playing_queued){
			input_move_magnitude = 0;
			velocity.x = 0;
			acceleration.x = 0;
		}
		else if(movement_path_enable){
			if(movement_path_direction){
				if(x < movement_path_end_x){
					input_aim_direction = 0;
					input_move_direction = input_aim_direction;
					input_move_magnitude = 1;
					acceleration.AddMagnitudeDirection(INPUT_MOVE_ACCELERATION*input_move_magnitude,input_move_direction);
				}
				//Arrived
				else{
					//Swap Direction
					movement_path_direction = -1;
				}
			}
			else{
				if(x > movement_path_start_x){
					input_aim_direction = 180;
					input_move_direction = input_aim_direction;
					input_move_magnitude = 1;
					acceleration.AddMagnitudeDirection(INPUT_MOVE_ACCELERATION*input_move_magnitude,input_move_direction);
				}
				//Arrived
				else{
					//Swap Direction
					movement_path_direction = 1;
				}
			}
		}
		else if(move_grounded){
			//Detla Time Factor
			var _delta_time;
			if(time_scale_enable)
				_delta_time = global.delta_time_factor_scaled;
			else
				_delta_time = global.delta_time_factor;

			// Hostile follow: steer toward player X unless a recent object/spike reversal
			// is holding movement in the opposite direction for a short time.
			if(is_hostile){
				if(hostile_obstacle_reverse_lock_time > 0){
					hostile_obstacle_reverse_lock_time = max(0, hostile_obstacle_reverse_lock_time - _delta_time);
					input_aim_direction = hostile_obstacle_reverse_direction;
				}
				else{
					target_update(TargetType.attack);
					input_aim_direction = (target[TargetType.attack].x >= x) ? 0 : 180;
				}
			}

			// Patrol: after N walk loops, flip direction (this will trigger the queued turn animation later)
			if(!is_hostile && patrol_pending_turn){
				patrol_pending_turn = false;
				input_aim_direction = (input_aim_direction == 0) ? 180 : 0;
				face_horizontal = (input_aim_direction == 0) ? 1 : -1;
				velocity.x = 0;
				// Reset frame tracking to prevent false loop detection after turn
				patrol_walk_frame_prev = walk_relaxed_walk_start;

				// Queue turn sprite immediately (do not rely on later face-change detection)
				if(!image.is_playing_queued){
					var _patrol_turn_sprite = noone;
					if(sprite_direction_enable && (sprite_turn_relaxed_left != noone) && (sprite_turn_relaxed_right != noone)){
						_patrol_turn_sprite = enemy_sprite_get_directional(sprite_turn_relaxed_left, sprite_turn_relaxed_right);
					}
					else if(sprite_turn_relaxed != noone){
						_patrol_turn_sprite = sprite_turn_relaxed;
					}
					if(_patrol_turn_sprite != noone){
						image_system_queue_add_to_front(_patrol_turn_sprite, ANIMATION_FPS_DEFAULT * animation_fps_multiplier);
					}
				}
			}

			// Compute displacement magnitude (distance) but use intended direction
			var _acceleration_multiplier = 0.5 * _delta_time;
			var _disp_mag = abs((velocity.x + acceleration.x * _acceleration_multiplier) * _delta_time);

			// Use sprite-based lookahead distance for reliable blocker detection
			var _lookahead_extra = obstacle_turn_lookahead_extra_px;
			_lookahead_extra ??= 6;
			var _lookahead = max(_disp_mag, sprite_width/2 + _lookahead_extra);
			var _next_x = x + _lookahead * lengthdir_x(1, input_aim_direction);

			var _ground_probe_y = obstacle_turn_ground_probe_y_offset;
			_ground_probe_y ??= 2;
			var _body_probe_y = obstacle_turn_body_probe_y_offset;
			_body_probe_y ??= 0;

			var _ground_ahead = place_meeting(_next_x, y + _ground_probe_y, move_collision_object);
			var _solid_ahead = place_meeting(_next_x, y + _body_probe_y, move_collision_object) || (collision.x != 0);

			var _spike_ahead = false;
			if(obstacle_turn_block_spikes_enable){
				var _spike_instance = instance_place(_next_x, y + _body_probe_y, o_spikes);
				if(_spike_instance != noone){
					var _spike_blocks = true;
					if(variable_instance_exists(_spike_instance, "retractable_enable") && _spike_instance.retractable_enable){
						_spike_blocks = false;

						var _spike_scale = 1;
						if(variable_instance_exists(_spike_instance, "transform")){
							var _spike_anchor = _spike_instance.transform[TransformType.anchor];
							if(_spike_anchor != noone){
								_spike_scale = abs(_spike_anchor.value[TransformValue.yscale].current);
							}
						}

						_spike_blocks = (_spike_scale > obstacle_turn_spike_active_scale_min);
					}

					_spike_ahead = _spike_blocks;
				}
			}

			var _blocked_by_object = _solid_ahead || _spike_ahead;
			var _blocked_by_edge = (!_ground_ahead && !_blocked_by_object);

			if(_blocked_by_object || _blocked_by_edge){
				// Objects/spikes always reverse. Edges preserve hostile stop-at-edge behavior.
				var _reverse_direction = _blocked_by_object || !(is_hostile && hostile_stop_at_edges_enable);

				// Stop before blocker/edge.
				velocity.x = 0;
				acceleration.x = 0;
				input_move_magnitude = 0;

				if(_reverse_direction){
					input_aim_direction = (input_aim_direction == 0) ? 180 : 0;
					face_horizontal = (input_aim_direction == 0) ? 1 : -1;

					if(is_hostile && _blocked_by_object){
						hostile_obstacle_reverse_direction = input_aim_direction;
						hostile_obstacle_reverse_lock_time = hostile_obstacle_reverse_lock_time_max;
					}

					// If patrol auto-turn is enabled, reset the loop counter when we turn due to an edge/blocker.
					if(!is_hostile && patrol_turn_after_walk_loops_enable){
						patrol_walk_loops_count = 0;
						patrol_pending_turn = false;
						// Reset frame tracking to prevent false loop detection after turn
						patrol_walk_frame_prev = walk_relaxed_walk_start;
					}

					// Queue turn sprite immediately (do not rely on later face-change detection)
					if(!image.is_playing_queued){
						var _turn_sprite = noone;
						if(is_hostile){
							if(sprite_direction_enable && (sprite_turn_hostile_left != noone) && (sprite_turn_hostile_right != noone)){
								_turn_sprite = enemy_sprite_get_directional(sprite_turn_hostile_left, sprite_turn_hostile_right);
							}
						}
						else{
							if(sprite_direction_enable && (sprite_turn_relaxed_left != noone) && (sprite_turn_relaxed_right != noone)){
								_turn_sprite = enemy_sprite_get_directional(sprite_turn_relaxed_left, sprite_turn_relaxed_right);
							}
							else if(sprite_turn_relaxed != noone){
								_turn_sprite = sprite_turn_relaxed;
							}
						}
						if(_turn_sprite != noone){
							image_system_queue_add_to_front(_turn_sprite, ANIMATION_FPS_DEFAULT * animation_fps_multiplier);
						}
					}
				}
				else{
					// Hostile edge-stop: keep tracking target, but do not flip away.
					input_move_magnitude = 0;
				}
			}
			else{
				input_move_direction = input_aim_direction;
				input_move_magnitude = 1;
				acceleration.AddMagnitudeDirection(INPUT_MOVE_ACCELERATION*input_move_magnitude,input_move_direction);
			}
		}
	#endregion

	#region Animation (idle / walk selection)
		// Selection of sprites and loop ranges
		var _moving;
		_moving = (input_move_magnitude > 0) || (abs(velocity.x) > 0.05) || (sprite_animation_extended_enable && image.is_playing_queued);

		var _target_sprite = noone;
		var _target_loop_start = 0;
		var _target_loop_end = IMAGE_LOOP_FULL;
		var _target_loop = true;
		var _target_animate = true;

		if(is_hostile){
			// Hostile uses combined walk_hostile sprite (idle 0-13, walk 14-30)
			_target_sprite = enemy_sprite_get_directional(sprite_walk_hostile_left,sprite_walk_hostile_right);

			if(_target_sprite != noone){
				if(_moving){
					_target_loop_start = walk_hostile_walk_start;
					_target_loop_end = (walk_hostile_walk_end > 0) ? (walk_hostile_walk_end + 1) : IMAGE_LOOP_FULL;
				}
				else{
					_target_loop_start = walk_hostile_idle_start;
					_target_loop_end = (walk_hostile_idle_end > 0) ? (walk_hostile_idle_end + 1) : IMAGE_LOOP_FULL;
				}
			}
		}
		else{
			// Relaxed
			_target_sprite = enemy_sprite_get_directional(sprite_walk_relaxed_left,sprite_walk_relaxed_right);

			if(_target_sprite != noone){
				var _use_idle_loop = (!_moving) && (stationary_time > 0.25);
				if(_use_idle_loop){
					_target_loop_start = walk_relaxed_idle_start;
					_target_loop_end = (walk_relaxed_idle_end > 0) ? (walk_relaxed_idle_end + 1) : IMAGE_LOOP_FULL;
				}else{
					_target_loop_start = walk_relaxed_walk_start;
					_target_loop_end = (walk_relaxed_walk_end > 0) ? (walk_relaxed_walk_end + 1) : IMAGE_LOOP_FULL;
				}
			}
		}

		// Apply selection
		if(sprite_animation_extended_enable && _target_sprite != noone){
			if(!image.is_playing_queued){
				// Not queued: update immediately
				if(sprite_current != _target_sprite || image.loop_start != _target_loop_start || image.loop_end != _target_loop_end){
					image_system_setup(_target_sprite, ANIMATION_FPS_DEFAULT * animation_fps_multiplier, _target_animate, _target_loop, _target_loop_start, _target_loop_end);
					image_set_frame(image, _target_loop_start);
				}
			}
			else{
				// Currently playing a queued animation: update the target only
				// so when the queue ends, it switches to the correct directional sprite.
				image.target_sprite = _target_sprite;
				image.target_loop_start = _target_loop_start;
				image.target_loop_end = _target_loop_end;
				image.target_loop = _target_loop;
				image.target_animate = _target_animate;
			}
		}
	#endregion

	#region Combat
		// Only attack when hostile (unless subclass overrides with custom move-state attack logic)
		if(is_hostile && attack_start_in_move_enable){
			//Update Target
			target_update(TargetType.attack);

			//Target is Within Range
			if(target[TargetType.attack].is_within_trigger_distance()){
				// Check vertical distance (only attack if height difference is within enemy height)
				var _v_dist;
				_v_dist = abs(target[TargetType.attack].y - y);

				if(_v_dist <= height){
					//Can Attack
					if(attack_countdown <= 0){
						var _can_start_attack;
						_can_start_attack = true;

						// Optionally require that we're already facing the target to start an attack
						// (prevents snapping into an attack while patrolling the opposite direction)
						if(attack_requires_facing_target_enable){
							var _target_face;
							_target_face = (target[TargetType.attack].x >= x) ? 1 : -1;
							if(face_horizontal != _target_face){
								// Not facing the target yet, so don't start the attack.
								// (We keep normal movement behaviour; facing may change naturally over time.)
								_can_start_attack = false;
							}
						}

						if(_can_start_attack){
							//Go to Telegraph State
							state = EnemyState.attack_telegraph;

							//Update Sprite
							var _attack_sprite;
							_attack_sprite = sprite_attack_telegraph;
							if(sprite_direction_enable && (sprite_attack_left != noone) && (sprite_attack_right != noone)){
								_attack_sprite = enemy_sprite_get_directional(sprite_attack_left,sprite_attack_right);
							}

							image_system_setup(_attack_sprite,ANIMATION_FPS_DEFAULT * animation_fps_multiplier,true,true,0,IMAGE_LOOP_FULL);

							// Lock facing for the full attack using CURRENT facing
							// (attack_requires_facing_target_enable ensures we're already facing the target)
							attack_face_lock_active = true;
							attack_face_horizontal_lock = face_horizontal;

							//Attack Created Reset
							attack_active_attack_created = false;

							//Reset Attack Countdowns
							attack_telegraph_countdown = attack_telegraph_countdown_max;
							attack_active_countdown = attack_telegraph_countdown_max;
							attack_recover_countdown = attack_telegraph_countdown_max;

							// Stop processing move logic this step (prevents face/turn updates after entering attack state)
							return;
						}
					}
				}
			}
		}
	#endregion

	#region De-aggro Detection
		// When hostile and de-aggro is enabled, track if player is out of range.
		if(is_hostile && deaggro_enable){
			var _target_exists;
			_target_exists = target_update(TargetType.attack);

			var _out_of_range;
			_out_of_range = true;

			if(_target_exists){
				var _distance_to_target;
				_distance_to_target = point_distance(x, y, target[TargetType.attack].x, target[TargetType.attack].y);

				// De-aggro uses a radial distance threshold.
				var _deaggro_distance_threshold;
				if(variable_instance_exists(id, "deaggro_distance_threshold")){
					_deaggro_distance_threshold = deaggro_distance_threshold;
				}
				else{
					// Legacy fallback for older objects that still set the old variable.
					_deaggro_distance_threshold = deaggro_y_distance_threshold;
				}

				// Keep legacy alias in sync while old content still references it.
				if(variable_instance_exists(id, "deaggro_y_distance_threshold")){
					deaggro_y_distance_threshold = _deaggro_distance_threshold;
				}

				_out_of_range = _distance_to_target > _deaggro_distance_threshold;
			}

			if(_out_of_range){
				// Player is out of range - increment timer.
				deaggro_timer += global.delta_time_factor_scaled;

				if(deaggro_timer >= deaggro_timer_max){
					// De-aggro: transition to sheathe state
					state = EnemyState.sheathe;
					return;
				}
			}
			else{
				// Player is within range - reset timer.
				deaggro_timer = 0;
			}
		}
	#endregion

	//Face - with turn animation
	character_face(false);

	//Check for direction change while grounded (only while in move state)
	if(move_grounded && (_face_horizontal_prev != face_horizontal) && !image.is_playing_queued && (state == EnemyState.move)){
		var _turn_sprite;
		_turn_sprite = noone;

		if(is_hostile){
			// Use directional turn sprite based on NEW facing direction
			if(sprite_direction_enable && (sprite_turn_hostile_left != noone) && (sprite_turn_hostile_right != noone)){
				_turn_sprite = enemy_sprite_get_directional(sprite_turn_hostile_left, sprite_turn_hostile_right);
			}
		}
		else{
			// Relaxed turn - use directional sprites if available, otherwise fall back to symmetric
			if(sprite_direction_enable && (sprite_turn_relaxed_left != noone) && (sprite_turn_relaxed_right != noone)){
				_turn_sprite = enemy_sprite_get_directional(sprite_turn_relaxed_left, sprite_turn_relaxed_right);
			}
			else if(sprite_turn_relaxed != noone){
				_turn_sprite = sprite_turn_relaxed;
			}
		}

		if(_turn_sprite != noone){
			image_system_queue_add_to_front(_turn_sprite, ANIMATION_FPS_DEFAULT * animation_fps_multiplier);
		}
	}

	#region Out of Room
		if((x < 0) || (x > room_width) || (y < 0) || (y > room_height)){
			character_kill();
		}
	#endregion
}

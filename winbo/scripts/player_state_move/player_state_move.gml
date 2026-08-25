function player_state_move(){
	var _delta_time_scaled;
	_delta_time_scaled = global.delta_time_factor_scaled;

	//Input
	player_input();

	var _bump_block, _landing_block;
	_bump_block = (sprite_current == sprite_bump) && (sprite_current_frame < (image.sprite_number - 1));
	_landing_block = ((sprite_current == sprite_land) || (sprite_current == sprite_land_sideways)) && (sprite_current_frame < (image.sprite_number - 1));

	var _secret_idle_gate_open, _secret_idle_gameplay_input;
	_secret_idle_gate_open = player_secret_idle_gate_open(_bump_block, _landing_block);
	_secret_idle_gameplay_input = player_secret_idle_has_gameplay_input();

	if(secret_idle_phase != PLAYER_SECRET_IDLE_PHASE_INACTIVE){
		if(_secret_idle_gameplay_input || !_secret_idle_gate_open){
			player_secret_idle_cancel(true);
		}
		else{
			switch(secret_idle_phase){
				case PLAYER_SECRET_IDLE_PHASE_SITDOWN:
					if(sprite_current != sprite_sitdown){
						image_system_setup(sprite_sitdown, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
						image_set_frame(image, 0);
					}

					if(sprite_current_frame >= (image.sprite_number - 1)){
						player_secret_idle_begin_body();
					}
				break;

				case PLAYER_SECRET_IDLE_PHASE_INTRO:
					if(sprite_current != sprite_secret_idle){
						player_secret_idle_begin_body();
					}
					else if(sprite_current_frame >= 7){
						player_secret_idle_begin_loop();
					}
				break;

				case PLAYER_SECRET_IDLE_PHASE_LOOP:
					if(sprite_current != sprite_secret_idle){
						image_system_setup(sprite_secret_idle, ANIMATION_FPS_DEFAULT, true, true, 7, 17);
						image_set_frame(image, 7);
					}
				break;
			}
		}
	}
	else if(_secret_idle_gate_open && !_secret_idle_gameplay_input){
		secret_idle_inputless_time += _delta_time_scaled;

		if(secret_idle_inputless_time >= secret_idle_activation_time){
			player_secret_idle_start();
		}
	}
	else{
		secret_idle_inputless_time = 0;
	}

	var _frolic_allowed;
	_frolic_allowed = player_frolic_can_activate(_bump_block, _landing_block);
	player_frolic_update(_frolic_allowed);

	var _air_spin_playing;
	_air_spin_playing = player_air_spin_update_state();

	#region Sprite Update
		if(!_bump_block && !_landing_block && !image.is_playing_queued){
			if(move_grounded){
				switch(secret_idle_phase){
					case PLAYER_SECRET_IDLE_PHASE_SITDOWN:
						if(sprite_current != sprite_sitdown){
							image_system_setup(sprite_sitdown, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
							image_set_frame(image, 0);
						}
					break;

					case PLAYER_SECRET_IDLE_PHASE_INTRO:
						if(sprite_current != sprite_secret_idle){
							player_secret_idle_begin_body();
						}
					break;

					case PLAYER_SECRET_IDLE_PHASE_LOOP:
						if(sprite_current != sprite_secret_idle){
							image_system_setup(sprite_secret_idle, ANIMATION_FPS_DEFAULT, true, true, 7, 17);
							image_set_frame(image, 7);
						}
					break;

					default:
						if(stationary){
							if(sprite_current != sprite_idle){
								image_system_setup(sprite_idle, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
							}
						}
						else if(frolic_active){
							if(sprite_current != sprite_frolic){
								player_frolic_begin_sprite();
							}
						}
						else{
							if(sprite_current != sprite_walk){
								if(sprite_current == sprite_land_sideways){
									image_system_setup(sprite_walk, ANIMATION_FPS_DEFAULT, true, true, 4, IMAGE_LOOP_FULL);
									image_set_frame(image, 1);
								}
								else if(sprite_current == sprite_frolic){
									player_frolic_end_to_walk();
								}
								else{
									image_system_setup(sprite_walk, ANIMATION_FPS_DEFAULT, true, true, 4, IMAGE_LOOP_FULL);
								}
							}
						}
					break;
				}
			}
			else{
				player_frolic_clear();

				if(_air_spin_playing){
					if(sprite_current != sprite_air_spin){
						player_air_spin_begin_sprite();
					}
				}
				else{
					if((acceleration.y < 0) || (velocity.y < 0)){
						if((sprite_current != sprite_jump) && (sprite_current != sprite_jump_sideways)){
							var _use_sideways_jump, _target_jump_sprite;
							_use_sideways_jump = (abs(velocity.x) > 5);
							_target_jump_sprite = _use_sideways_jump ? sprite_jump_sideways : sprite_jump;

							image_system_setup(_target_jump_sprite, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
						}
						else{
							var _should_use_sideways_jump, _current_jump_is_sideways;
							_should_use_sideways_jump = (abs(velocity.x) > 5);
							_current_jump_is_sideways = (sprite_current == sprite_jump_sideways);

							if(_should_use_sideways_jump != _current_jump_is_sideways){
								var _target_jump_sprite;
								_target_jump_sprite = _should_use_sideways_jump ? sprite_jump_sideways : sprite_jump;
								image_set_sprite(image, _target_jump_sprite, false);
							}
						}
					}
					else{
						if(((sprite_current == sprite_jump) || (sprite_current == sprite_jump_sideways)) && (sprite_current_frame < image.sprite_number - 1)){
						}
						else{
							if((sprite_current != sprite_fall) && (sprite_current != sprite_fall_sideways)){
								var _use_sideways_fall, _target_fall_sprite;
								_use_sideways_fall = (abs(velocity.x) > 5);
								_target_fall_sprite = _use_sideways_fall ? sprite_fall_sideways : sprite_fall;

								if(sprite_current == sprite_float){
									if(!image.is_playing_queued){
										var _float_transition_sprite;
										_float_transition_sprite = _use_sideways_fall ? sprite_transition_float_to_fall_sideways : sprite_transition_float_to_fall;
										image_system_setup(_target_fall_sprite, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
										image_system_queue_add_to_front(_float_transition_sprite, ANIMATION_FPS_DEFAULT);
									}
								}
								else if(sprite_current == sprite_bump){
									if(!image.is_playing_queued){
										var _bump_transition_sprite;
										_bump_transition_sprite = _use_sideways_fall ? sprite_transition_bump_to_fall_sideways : sprite_transition_bump_to_fall;
										image_system_setup(_target_fall_sprite, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
										image_system_queue_add_to_front(_bump_transition_sprite, ANIMATION_FPS_DEFAULT);
									}
								}
								else if((sprite_current == sprite_jump_sideways) && _use_sideways_fall){
									if(!image.is_playing_queued){
										image_system_setup(_target_fall_sprite, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
										image_system_queue_add_to_front(sprite_transition_jump_sideways_to_fall_sideways, ANIMATION_FPS_DEFAULT);
									}
								}
								else{
									image_system_setup(_target_fall_sprite, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
								}
							}
							else{
								var _should_use_sideways_fall, _current_fall_is_sideways;
								_should_use_sideways_fall = (abs(velocity.x) > 5);
								_current_fall_is_sideways = (sprite_current == sprite_fall_sideways);

								if(_should_use_sideways_fall != _current_fall_is_sideways){
									var _target_fall_sprite;
									_target_fall_sprite = _should_use_sideways_fall ? sprite_fall_sideways : sprite_fall;
									image_set_sprite(image, _target_fall_sprite, false);
								}
							}
						}
					}
				}
			}
		}
	#endregion

	//Update Health
	character_health();

	acceleration.AddMagnitudeDirection(INPUT_MOVE_ACCELERATION * input_move_magnitude, input_move_direction);

	#region Arrow Input
		if(keyboard_check(vk_up)){
			input_current[UserControl.jump] = true;
		}

		if(keyboard_check_pressed(vk_down)){
			input_current[UserControl.down] = true;
		}

		var _left_key, _right_key;
		_left_key = keyboard_check_pressed(vk_left);
		_right_key = keyboard_check_pressed(vk_right);

		if(_left_key || _right_key){
			input_current[UserControl.dash] = true;

			if(_left_key){
				input_move_direction = 180;
			}
			else if(_right_key){
				input_move_direction = 0;
			}

			input_move_magnitude = 1;
			input_aim_direction = input_move_direction;
		}

		// Jump and Float share W on keyboard. Work out whether this press belongs
		// to a real ground/bounce jump before allowing Float to consume it.
		var _jump_pressed_now, _close_enough_to_jump, _jump_available_now;
		_jump_pressed_now = input_current[UserControl.jump] && !input_previous[UserControl.jump];
		_close_enough_to_jump = move_grounded_close && (velocity.y > 0);
		_jump_available_now = (bump_jump_count > 0) || move_grounded || _close_enough_to_jump;

		if(player_dive_spring_float_input_active() && !(_jump_pressed_now && _jump_available_now)){
			if((float_countdown > 0) && (!move_grounded)){
				if((acceleration.y >= 0) && (velocity.y >= 0)){
					player_frolic_clear();
					fx_spawn_sprite_follow_once(id, 0, 0, "lyr_pfx_foreground", spr_fx_float_burst, face_horizontal, 1, 0, 18);
					state = PlayerState.float;
				}
			}
		}
	#endregion

	if(player_dive_spring_try_start()){
		return;
	}

	if(input_move_magnitude > 0){
		dash_no_input_direction = input_move_direction;
	}

	#region Jump
		if(_jump_pressed_now){
			if(_jump_available_now){
				player_frolic_clear();

				acceleration.AddMagnitudeDirection(input_move_acceleration_jump, 90);
				jump_hold_allow_countdown = jump_hold_allow_countdown_max;
				move_gravity.Copy(move_gravity_rise);

				if(bump_jump_count > 0){
					bump_jump_count--;
				}

				with(o_camera){
					if(follow_jump_dampening_enable){
						follow_jump_dampening_factor = 0;
					}
				}

				if(jump_smoke_fx_enable && move_grounded){
					var _jump_smoke_sprite, _jump_smoke_xscale;
					_jump_smoke_sprite = (input_move_magnitude > 0.1) ? spr_smoke_jump_diagonal : spr_smoke_jump_upward;
					_jump_smoke_xscale = 1;

					if(input_move_magnitude > 0.1){
						_jump_smoke_xscale = (input_move_direction > 90 && input_move_direction < 270) ? 1 : -1;
					}

					fx_spawn_sprite_once(x, bbox_bottom, "lyr_pfx_midground", _jump_smoke_sprite, _jump_smoke_xscale, 1, 0, ANIMATION_FPS_DEFAULT);
				}
			}
		}
	#endregion

	#region Jump Hold (Variable Jump Height)
		if(jump_hold_enable && !move_grounded){
			if(!input_current[UserControl.jump]){
				jump_hold_allow_countdown = 0;
			}

			if(input_current[UserControl.jump] && jump_hold_allow_countdown > 0){
				acceleration.AddMagnitudeDirection(input_move_acceleration_jump * 0.08, 90);
			}
		}
	#endregion

	#region Grounded
		if(move_grounded){
			dash_stamina = dash_stamina_max;
			dash_stamina_depleted = false;
			float_countdown = float_countdown_max;
		}
	#endregion

	#region Drop Through
		if(move_grounded && move_grounded_instance != noone){
			if(move_grounded_instance.drop_through_enabled){
				if(input_current[UserControl.down]){
					player_frolic_clear();

					move_drop_through_instance = move_grounded_instance;
					move_grounded = false;
					move_grounded_instance = noone;

					y += 10;
					transform_set(transform[TransformType.anchor], TransformValue.y, 10, true);
				}
			}
		}
	#endregion

	var _face_horizontal_prev;
	_face_horizontal_prev = face_horizontal;
	character_face(false);

	if(move_grounded && !stationary && !frolic_active && (secret_idle_phase == PLAYER_SECRET_IDLE_PHASE_INACTIVE) && (_face_horizontal_prev != face_horizontal)){
		image_system_queue_add_to_front(sprite_transition_walk_to_walk_other_direction, ANIMATION_FPS_DEFAULT);

		if(quick_smoke_fx_enable){
			fx_spawn_sprite_once(x, bbox_bottom, "lyr_pfx_foreground", spr_smoke_sharp_movement, face_horizontal, 1, 0, ANIMATION_FPS_DEFAULT);
		}
	}

	character_dash();

	#region Out of Room
		if((x < 0) || (x > room_width) || (y < 0) || (y > room_height)){
			character_kill();
		}
	#endregion

	player_collisions();
	var _air_spin_launch_step;
	_air_spin_launch_step = player_air_spin_movement_begin();
	player_movement_update();
	player_air_spin_movement_end(_air_spin_launch_step);
	player_mushroom_collisions_post_movement();
	player_landing_smoke_update();

	if(move_grounded){
		player_air_spin_clear();
	}

	if(!move_grounded){
		player_frolic_clear();
	}

	if((secret_idle_phase != PLAYER_SECRET_IDLE_PHASE_INACTIVE) && (!move_grounded || !stationary)){
		player_secret_idle_cancel(true);
	}
}

function player_secret_idle_has_gameplay_input(){
	if(input_move_magnitude > 0){
		return true;
	}

	if(
		input_current[UserControl.up] ||
		input_current[UserControl.down] ||
		input_current[UserControl.left] ||
		input_current[UserControl.right] ||
		input_current[UserControl.jump] ||
		input_current[UserControl.dash] ||
		input_current[UserControl.attack] ||
		input_current[UserControl.interact] ||
		input_current[UserControl.interact_equip] ||
		input_current[UserControl.float] ||
		input_current[UserControl.run]
	){
		return true;
	}

	return keyboard_check(vk_up)
		|| keyboard_check_pressed(vk_down)
		|| keyboard_check_pressed(vk_left)
		|| keyboard_check_pressed(vk_right);
}

function player_landing_smoke_update(){
	if(!move_grounded){
		landing_smoke_armed = true;
		return;
	}

	if(landing_smoke_armed){
		landing_smoke_armed = false;
		fx_spawn_sprite_once(x, bbox_bottom, "lyr_pfx_foreground", spr_fx_smoke_landing, 1, 1, 0, 18);
	}
}

function player_secret_idle_gate_open(_bump_block, _landing_block){
	return (global.game_state == GameState.play)
		&& (state == PlayerState.move)
		&& move_grounded
		&& stationary
		&& !_bump_block
		&& !_landing_block
		&& !image.is_playing_queued;
}

function player_secret_idle_start(){
	player_frolic_clear();

	if(secret_idle_thought_fx != noone){
		with(secret_idle_thought_fx){
			instance_destroy();
		}

		secret_idle_thought_fx = noone;
	}

	secret_idle_inputless_time = secret_idle_activation_time;
	secret_idle_phase = PLAYER_SECRET_IDLE_PHASE_SITDOWN;
	secret_idle_thought_index = -1;

	image_system_setup(sprite_sitdown, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
	image_set_frame(image, 0);
}

function player_secret_idle_begin_body(){
	secret_idle_phase = PLAYER_SECRET_IDLE_PHASE_INTRO;
	image_system_setup(sprite_secret_idle, ANIMATION_FPS_DEFAULT, true, true, 7, 17);
	image_set_frame(image, 0);
}

function player_secret_idle_begin_loop(){
	if(secret_idle_phase == PLAYER_SECRET_IDLE_PHASE_LOOP){
		return;
	}

	secret_idle_phase = PLAYER_SECRET_IDLE_PHASE_LOOP;

	if(secret_idle_thought_index < 0){
		var _thought_count;
		_thought_count = array_length(secret_idle_thought_sprites);
		secret_idle_thought_index = irandom(_thought_count - 1);

		if((_thought_count > 1) && (secret_idle_thought_index == secret_idle_thought_previous_index)){
			secret_idle_thought_index = (secret_idle_thought_index + 1 + irandom(_thought_count - 2)) mod _thought_count;
		}
	}

	secret_idle_thought_previous_index = secret_idle_thought_index;

	if(secret_idle_thought_fx != noone){
		with(secret_idle_thought_fx){
			instance_destroy();
		}
	}

	secret_idle_thought_fx = instance_create_layer(x + secret_idle_thought_offset_x, y + secret_idle_thought_offset_y, secret_idle_fx_layer, o_fx_player_secret_idle);

	with(secret_idle_thought_fx){
		fx_sprite = other.secret_idle_thought_sprites[other.secret_idle_thought_index];
		fx_fps = ANIMATION_FPS_DEFAULT;
		fx_owner = other.id;
		fx_offset_x = other.secret_idle_thought_offset_x;
		fx_offset_y = other.secret_idle_thought_offset_y;
		fx_follow_owner = true;
		fx_destroy_on_end = false;
		fx_fade_target = 1;
		fx_fade_speed = other.secret_idle_thought_fade_speed;
		image_alpha = 0;
	}
}

function player_secret_idle_cancel(_spawn_bubble_out = true){
	var _bubble_visible, _bubble_x, _bubble_y;
	_bubble_visible = (secret_idle_phase == PLAYER_SECRET_IDLE_PHASE_LOOP) || (secret_idle_thought_fx != noone);
	_bubble_x = x + secret_idle_thought_offset_x;
	_bubble_y = y + secret_idle_thought_offset_y;

	if(secret_idle_thought_fx != noone){
		_bubble_x = secret_idle_thought_fx.x;
		_bubble_y = secret_idle_thought_fx.y;

		with(secret_idle_thought_fx){
			instance_destroy();
		}

		secret_idle_thought_fx = noone;
	}

	if(_spawn_bubble_out && _bubble_visible){
		with(instance_create_layer(_bubble_x, _bubble_y, secret_idle_fx_layer, o_fx_player_secret_idle)){
			fx_sprite = other.sprite_secret_idle_bubble_out;
			fx_fps = ANIMATION_FPS_DEFAULT;
			fx_destroy_on_end = true;
			image_alpha = 1;
		}
	}

	secret_idle_inputless_time = 0;
	secret_idle_phase = PLAYER_SECRET_IDLE_PHASE_INACTIVE;
	secret_idle_thought_index = -1;
}

function player_frolic_can_activate(_bump_block, _landing_block){
	return (state == PlayerState.move)
		&& (secret_idle_phase == PLAYER_SECRET_IDLE_PHASE_INACTIVE)
		&& move_grounded
		&& (input_move_magnitude > 0)
		&& !stationary
		&& input_current[UserControl.run]
		&& !_bump_block
		&& !_landing_block
		&& !image.is_playing_queued;
}

function player_frolic_clear(){
	frolic_active = false;
	frolic_ramp_time = 0;
	movement_input_move_acceleration_factor_set(1);
}

function player_frolic_update(_frolic_allowed){
	if(!_frolic_allowed){
		player_frolic_clear();
		return;
	}

	if(!frolic_active){
		frolic_active = true;
		frolic_ramp_time = 0;
	}

	if(frolic_ramp_time < frolic_ramp_time_max){
		frolic_ramp_time = min(frolic_ramp_time_max, frolic_ramp_time + global.delta_time_factor_scaled);
	}

	var _frolic_progress, _frolic_factor;
	_frolic_progress = 1;
	if(frolic_ramp_time_max > 0){
		_frolic_progress = clamp(frolic_ramp_time / frolic_ramp_time_max, 0, 1);
	}

	_frolic_factor = lerp(1, frolic_acceleration_factor, _frolic_progress);
	movement_input_move_acceleration_factor_set(_frolic_factor);
}

function player_air_spin_start(){
	air_spin_active = true;
	air_spin_apex_seen = false;
	air_spin_launch_pending = true;
	player_frolic_clear();
	player_air_spin_begin_sprite();
}

function player_air_spin_clear(){
	air_spin_active = false;
	air_spin_apex_seen = false;
	air_spin_launch_pending = false;
}

function player_air_spin_movement_begin(){
	if(!air_spin_active){
		return false;
	}

	var _delta_time_scaled;
	_delta_time_scaled = max(global.delta_time_factor_scaled, 0.0001);
	air_spin_movement_override_active = true;
	air_spin_velocity_retention_aerial_previous = velocity_retention_aerial;
	velocity_retention_aerial = power(air_spin_velocity_retention_aerial_previous, _delta_time_scaled);

	if(!air_spin_launch_pending){
		return false;
	}

	air_spin_launch_pending = false;
	air_spin_move_grounded_check_previous = move_grounded_check;
	air_spin_velocity_retention_previous = velocity_retention;
	acceleration.y /= _delta_time_scaled;
	move_grounded = false;
	move_grounded_instance = noone;
	move_grounded_check = false;
	velocity_retention = air_spin_velocity_retention_aerial_previous;
	return true;
}

function player_air_spin_movement_end(_launch_step){
	if(air_spin_movement_override_active){
		velocity_retention_aerial = air_spin_velocity_retention_aerial_previous;
		air_spin_movement_override_active = false;
	}

	if(!_launch_step){
		return;
	}

	move_grounded_check = air_spin_move_grounded_check_previous;
	velocity_retention = air_spin_velocity_retention_previous;
	move_grounded = false;
	move_grounded_instance = noone;
}

function player_air_spin_update_state(){
	if(!air_spin_active){
		return false;
	}

	if(move_grounded){
		player_air_spin_clear();
		return false;
	}

	// The bounce animation must finish and remain visible through the apex.
	// Clearing on its last frame made the normal jump sprite appear while Winbo
	// was still rising from the now-equal mushroom/enemy impulse.
	var _air_spin_animation_complete, _air_spin_at_or_past_apex;
	_air_spin_animation_complete = (sprite_current == sprite_air_spin)
		&& (sprite_current_frame >= (image.sprite_number - 1));
	_air_spin_at_or_past_apex = (velocity.y >= 0) && (acceleration.y >= 0);

	if(!air_spin_apex_seen && _air_spin_at_or_past_apex){
		air_spin_apex_seen = true;
		return true;
	}

	if(_air_spin_animation_complete && air_spin_apex_seen){
		player_air_spin_clear();
		return false;
	}

	return true;
}

function player_air_spin_begin_sprite(){
	image_system_setup(sprite_air_spin, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
	image_set_frame(image, 0);
}

function player_dive_spring_try_start(){
	var _down_pressed;
	_down_pressed = (input_current[UserControl.down] && !input_previous[UserControl.down]) || keyboard_check_pressed(vk_down);

	if(!_down_pressed || move_grounded){
		return false;
	}

	player_secret_idle_cancel(false);
	player_frolic_clear();
	player_air_spin_clear();

	state = PlayerState.dive_spring;
	dive_spring_phase = DiveSpringPhase.dive;
	dive_spring_impact_timer = 0;
	dive_spring_move_input_previous = input_move_magnitude;
	dive_spring_dive_timer = 0;
	dive_spring_enemy_impact = false;
	dive_spring_float_cancel_requested = false;
	dive_spring_dash_cancel_requested = false;
	dive_spring_apex_reached = false;
	dive_spring_launch_impulse_pending = false;
	dive_spring_momentum_x = velocity.x;
	dive_spring_velocity_retention_aerial_previous = velocity_retention_aerial;
	dive_spring_movement_override_active = true;
	velocity_retention_aerial = dive_spring_velocity_retention_aerial;

	dive_spring_start_speed = clamp(max(velocity.y, dive_spring_initial_speed), 0, dive_spring_max_speed);
	velocity.y = dive_spring_start_speed;

	dive_spring_startup_animation_active = true;
	image_system_setup(sprite_dive_spring, dive_spring_startup_fps, true, true, dive_spring_descent_loop_start_frame, dive_spring_descent_loop_end_frame);
	image_set_frame(image, 0);
	return true;
}

function player_state_dive_spring(){
	player_input();
	character_health();

	// A deep pit keeps the rotor loop instead of forcing an early transition,
	// so the spring phases need the same room-exit kill as the move state.
	if((x < 0) || (x > room_width) || (y < 0) || (y > room_height)){
		character_kill();
		return;
	}

	switch(dive_spring_phase){
		case DiveSpringPhase.dive:
			player_dive_spring_state_dive();
		break;

		case DiveSpringPhase.impact:
			player_dive_spring_state_impact();
		break;

		case DiveSpringPhase.spring:
			player_dive_spring_state_spring();
		break;

		case DiveSpringPhase.transition:
			player_dive_spring_state_transition();
		break;

		case DiveSpringPhase.fail:
			player_dive_spring_state_fail();
		break;
	}
}

function player_dive_spring_state_dive(){
	var _delta_time_scaled, _gravity_enable_previous, _dive_progress;
	_delta_time_scaled = global.delta_time_factor_scaled;
	dive_spring_dive_timer += _delta_time_scaled;
	dive_spring_enemy_impact = false;

	if(sprite_current != sprite_dive_spring){
		dive_spring_startup_animation_active = true;
		image_system_setup(sprite_dive_spring, dive_spring_startup_fps, true, true, dive_spring_descent_loop_start_frame, dive_spring_descent_loop_end_frame);
		image_set_frame(image, 0);
	}
	if(dive_spring_startup_animation_active && (image.position >= dive_spring_descent_loop_start_frame)){
		image_set_fps(image, ANIMATION_FPS_DEFAULT);
		dive_spring_startup_animation_active = false;
	}

	velocity.x = dive_spring_momentum_x;
	acceleration.x = 0;

	_dive_progress = clamp(dive_spring_dive_timer, 0, dive_spring_acceleration_time);
	velocity.y = ease_quad_in(dive_spring_start_speed, dive_spring_max_speed, false, _dive_progress, dive_spring_acceleration_time);
	acceleration.y = 0;

	_gravity_enable_previous = move_gravity_enable;
	move_gravity_enable = false;
	player_movement_update();
	move_gravity_enable = _gravity_enable_previous;
	velocity.y = min(velocity.y, dive_spring_max_speed);
	player_mushroom_collisions_post_movement();

	if((state != PlayerState.dive_spring) || (dive_spring_phase != DiveSpringPhase.dive)){
		return;
	}

	player_collisions();

	if((state != PlayerState.dive_spring) || (dive_spring_phase != DiveSpringPhase.dive)){
		return;
	}

	if(dive_spring_enemy_impact || move_grounded || (collision.x != 0) || (collision.y != 0)){
		player_dive_spring_begin_impact();
	}
}

function player_dive_spring_state_impact(){
	var _delta_time_scaled, _jump_pressed, _wrong_input_pressed;
	_delta_time_scaled = global.delta_time_factor_scaled;
	_jump_pressed = player_dive_spring_jump_pressed();
	_wrong_input_pressed = player_dive_spring_wrong_input_pressed();

	velocity.Set(0, 0);
	acceleration.Set(0, 0);
	dive_spring_impact_timer += _delta_time_scaled;

	if(sprite_current != sprite_dive_spring){
		image_system_setup(sprite_dive_spring, ANIMATION_FPS_DEFAULT, true, true, dive_spring_impact_loop_start_frame, dive_spring_impact_loop_end_frame);
		image_set_frame(image, dive_spring_impact_start_frame);
	}

	if(_wrong_input_pressed){
		player_dive_spring_begin_fail();
		return;
	}

	if(_jump_pressed){
		player_dive_spring_resolve_jump_timing();
		return;
	}

	if(dive_spring_impact_timer >= player_dive_spring_success_window_end()){
		player_dive_spring_begin_fail();
	}
}

function player_dive_spring_jump_pressed(){
	return ((input_current[UserControl.jump] && !input_previous[UserControl.jump])
		|| (input_current[UserControl.up] && !input_previous[UserControl.up])
		|| keyboard_check_pressed(vk_up));
}

function player_dive_spring_jump_active(){
	return input_current[UserControl.jump]
		|| input_current[UserControl.up]
		|| keyboard_check(vk_up);
}

function player_dive_spring_success_window_end(){
	return dive_spring_fail_window_max + dive_spring_success_window_max;
}

function player_dive_spring_resolve_jump_timing(){
	if((dive_spring_impact_timer >= dive_spring_fail_window_max) && (dive_spring_impact_timer < player_dive_spring_success_window_end())){
		player_dive_spring_begin_spring();
	}
	else{
		player_dive_spring_begin_fail();
	}
}

function player_dive_spring_wrong_input_pressed(){
	var _move_input_active, _move_input_previous_active;
	_move_input_active = input_move_magnitude > dive_spring_move_input_threshold;
	_move_input_previous_active = dive_spring_move_input_previous > dive_spring_move_input_threshold;
	dive_spring_move_input_previous = input_move_magnitude;

	if(_move_input_active && !_move_input_previous_active){
		return true;
	}

	if((input_current[UserControl.down] && !input_previous[UserControl.down]) || keyboard_check_pressed(vk_down)){
		return true;
	}

	if((input_current[UserControl.left] && !input_previous[UserControl.left]) || keyboard_check_pressed(vk_left)){
		return true;
	}

	if((input_current[UserControl.right] && !input_previous[UserControl.right]) || keyboard_check_pressed(vk_right)){
		return true;
	}

	if(input_current[UserControl.dash] && !input_previous[UserControl.dash]){
		return true;
	}

	if((input_current[UserControl.float] && !input_previous[UserControl.float]) && !player_dive_spring_jump_active()){
		return true;
	}

	if(input_current[UserControl.attack] && !input_previous[UserControl.attack]){
		return true;
	}

	if(input_current[UserControl.interact] && !input_previous[UserControl.interact]){
		return true;
	}

	if(input_current[UserControl.interact_equip] && !input_previous[UserControl.interact_equip]){
		return true;
	}

	if(input_current[UserControl.run] && !input_previous[UserControl.run]){
		return true;
	}

	return false;
}

function player_dive_spring_state_spring(){
	var _delta_time_scaled;
	_delta_time_scaled = max(global.delta_time_factor_scaled, 0.0001);
	var _launch_impulse_this_step, _move_grounded_check_previous, _velocity_retention_previous;
	_launch_impulse_this_step = false;
	_move_grounded_check_previous = move_grounded_check;
	_velocity_retention_previous = velocity_retention;

	if(dive_spring_launch_hold_time > 0){
		dive_spring_launch_hold_time = max(0, dive_spring_launch_hold_time - _delta_time_scaled);

		// Frame 8 is the grounded in-between before the launch: while the hold
		// runs, Winbo stays exactly where the impact landed and the pending
		// impulse must not be applied or integrated.
		if(dive_spring_launch_hold_time > 0){
			if(sprite_current != sprite_dive_spring){
				image_system_setup(sprite_dive_spring, 0, false, false, 0, IMAGE_LOOP_FULL);
			}

			image_set_frame(image, dive_spring_launch_frame);
			velocity.Set(0, 0);
			acceleration.Set(0, 0);
			return;
		}
	}

	if(sprite_current != sprite_dive_spring || !image.animate || image.loop_start != dive_spring_rotor_loop_start_frame){
		image_system_setup(sprite_dive_spring, dive_spring_rotor_fps, true, true, dive_spring_rotor_loop_start_frame, dive_spring_rotor_loop_end_frame);
		image_set_frame(image, dive_spring_rotor_loop_start_frame);
	}

	// The holding-right reference gains horizontal distance immediately rather
	// than waiting for an apex dash. Neutral input leaves x acceleration at zero.
	var _horizontal_acceleration_factor;
	_horizontal_acceleration_factor = dive_spring_apex_reached
		? dive_spring_horizontal_acceleration_factor_fall
		: dive_spring_horizontal_acceleration_factor_rise;
	acceleration.AddMagnitudeDirection(INPUT_MOVE_ACCELERATION * _horizontal_acceleration_factor * input_move_magnitude, input_move_direction);
	if(dive_spring_launch_impulse_pending){
		// Apply the launch as a fixed impulse. Dividing its one-step acceleration
		// by delta keeps the mockup trajectory stable when the runner drops frames.
		acceleration.AddMagnitudeDirection(input_move_acceleration_jump * dive_spring_jump_acceleration_factor / _delta_time_scaled, 90);
		dive_spring_launch_impulse_pending = false;
		_launch_impulse_this_step = true;
		// The collision ground probe can still report contact on the first upward
		// step. Force this one integration step to use the spring's aerial drag.
		move_grounded = false;
		move_grounded_instance = noone;
		move_grounded_check = false;
		velocity_retention = dive_spring_velocity_retention_aerial;
	}

	var _retention_base;
	_retention_base = dive_spring_apex_reached
		? dive_spring_velocity_retention_aerial_previous
		: dive_spring_velocity_retention_aerial;
	velocity_retention_aerial = power(_retention_base, _delta_time_scaled);
	if(dive_spring_apex_reached){
		move_gravity.Copy(move_gravity_fall);
	}
	else{
		move_gravity.Copy(move_gravity_rise);
	}
	player_movement_update();
	if(_launch_impulse_this_step){
		move_grounded_check = _move_grounded_check_previous;
		velocity_retention = _velocity_retention_previous;
		move_grounded = false;
		move_grounded_instance = noone;
	}
	player_mushroom_collisions_post_movement();

	if((state != PlayerState.dive_spring) || (dive_spring_phase != DiveSpringPhase.spring)){
		return;
	}

	player_collisions();

	if((state != PlayerState.dive_spring) || (dive_spring_phase != DiveSpringPhase.spring)){
		return;
	}

	player_dive_spring_float_cancel_update();
	player_dive_spring_dash_cancel_update();

	// An explicit cancel interrupts the rotor arc promptly; uninterrupted
	// flight keeps the rotor loop and the frames 15-16 landing transition.
	if(!move_grounded && player_dive_spring_dash_interrupt_try()){
		return;
	}

	if(!move_grounded && player_dive_spring_float_interrupt_try()){
		return;
	}

	if(!dive_spring_apex_reached && (velocity.y >= 0)){
		dive_spring_apex_reached = true;
		velocity.y = 0;
		acceleration.Set(0, 0);
	}
	else if(dive_spring_apex_reached){
		// Both supplied mockups keep the rotor through the apex and most of the
		// descent, then play frames 15-16 shortly before landing. Over a deep pit
		// the rotor must keep looping: never force the transition in mid-air.
		var _transition_near_ground;
		_transition_near_ground = place_meeting(x, y + dive_spring_transition_ground_probe_distance, move_collision_object);
		if(_transition_near_ground || move_grounded){
			dive_spring_phase = DiveSpringPhase.transition;
			acceleration.Set(0, 0);
			image_system_setup(sprite_dive_spring, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
			image_set_frame(image, dive_spring_transition_start_frame);
		}
	}
}

function player_dive_spring_state_transition(){
	var _delta_time_scaled;
	_delta_time_scaled = max(global.delta_time_factor_scaled, 0.0001);

	if(sprite_current != sprite_dive_spring){
		image_system_setup(sprite_dive_spring, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
		image_set_frame(image, dive_spring_transition_start_frame);
	}

	player_dive_spring_float_cancel_update();
	player_dive_spring_dash_cancel_update();
	acceleration.AddMagnitudeDirection(INPUT_MOVE_ACCELERATION * dive_spring_horizontal_acceleration_factor_fall * input_move_magnitude, input_move_direction);
	velocity_retention_aerial = power(dive_spring_velocity_retention_aerial_previous, _delta_time_scaled);
	move_gravity_factor = 1;
	move_gravity.Copy(move_gravity_fall);
	player_movement_update();
	player_mushroom_collisions_post_movement();

	if((state != PlayerState.dive_spring) || (dive_spring_phase != DiveSpringPhase.transition)){
		return;
	}

	player_collisions();

	if((state != PlayerState.dive_spring) || (dive_spring_phase != DiveSpringPhase.transition)){
		return;
	}

	if(move_grounded || (image.position >= (dive_spring_transition_end_frame + 1))){
		if(!move_grounded && player_dive_spring_dash_interrupt_try()){
			return;
		}

		if(!move_grounded && player_dive_spring_float_interrupt_try()){
			return;
		}

		var _target_fall_sprite;
		_target_fall_sprite = (abs(velocity.x) > 5) ? sprite_fall_sideways : sprite_fall;

		player_dive_spring_restore_movement();
		move_gravity.Copy(move_gravity_fall);
		dive_spring_phase = DiveSpringPhase.dive;
		state = PlayerState.move;

		if(move_grounded){
			if(stationary){
				image_system_setup(sprite_idle, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
			}
			else{
				image_system_setup(sprite_walk, ANIMATION_FPS_DEFAULT, true, true, 4, IMAGE_LOOP_FULL);
			}
		}
		else{
			image_system_setup(_target_fall_sprite, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
		}
	}
}

function player_dive_spring_float_cancel_update(){
	// Only a fresh press counts as a cancel request: the launch key is usually
	// still held during spring flight, and a stale hold must not interrupt the
	// rotor arc now that cancels execute promptly.
	if((input_current[UserControl.float] && !input_previous[UserControl.float]) || keyboard_check_pressed(vk_up)){
		dive_spring_float_cancel_requested = true;
	}
}

function player_dive_spring_dash_cancel_update(){
	var _left_key, _right_key;
	_left_key = keyboard_check_pressed(vk_left);
	_right_key = keyboard_check_pressed(vk_right);

	if(_left_key || _right_key){
		input_current[UserControl.dash] = true;
		input_move_direction = _left_key ? 180 : 0;
		input_move_magnitude = 1;
		input_aim_direction = input_move_direction;
	}

	if((input_current[UserControl.dash] && !input_previous[UserControl.dash]) || _left_key || _right_key){
		dive_spring_dash_cancel_requested = true;

		if(input_move_magnitude > 0){
			dash_no_input_direction = input_move_direction;
		}
	}
}

function player_dive_spring_dash_interrupt_try(){
	if(!dive_spring_dash_cancel_requested || !dash_enable || dash_stamina_depleted || (dash_cooldown > 0) || (dash_stamina < dash_stamina_cost) || !camera_visible){
		return false;
	}

	player_dive_spring_restore_movement();
	dive_spring_phase = DiveSpringPhase.dive;
	dive_spring_dash_cancel_requested = false;

	state = dash_state;
	dash_countdown = dash_countdown_max;
	dash_cooldown = dash_cooldown_max;
	dash_stamina -= dash_stamina_cost;

	if(dash_stamina < dash_stamina_cost){
		dash_stamina_depleted = true;
		dash_icon_animation_start = dash_icon_scale;
		dash_icon_animation_target = 1;
		dash_icon_animation_time_current = 0;
	}

	dash_hold_check_countdown = dash_hold_check_countdown_max;
	dash_hold_allow_countdown = dash_hold_allow_countdown_max;

	velocity.MultiplyFactor(0.5);
	acceleration.Set(0, 0);
	velocity_retention = dash_velocity_retention;

	if(input_move_magnitude <= 0){
		input_move_direction = dash_no_input_direction;
		input_aim_direction = input_move_direction;
	}

	face_horizontal = ((input_aim_direction > 90) && (input_aim_direction < 270)) ? -1 : 1;

	speed_stretch_enable = true;
	bump_triggered = false;
	bump_jump_count = 0;
	bump_allow = true;
	bump_allow_countdown = bump_allow_countdown_max;
	image_system_setup(sprite_dash, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
	audio_player_air_dash_play();

	camera_shake(0.1 * SECOND, 2);
	game_freeze(1);
	return true;
}

function player_dive_spring_float_interrupt_try(){
	if(!dive_spring_float_cancel_requested){
		return false;
	}

	// Float never engages while rising, matching the move-state float rule: a
	// request made during the rise is honored at the apex.
	if((float_countdown <= 0) || move_grounded || (velocity.y < 0)){
		return false;
	}

	player_dive_spring_restore_movement();
	dive_spring_phase = DiveSpringPhase.dive;
	dive_spring_float_cancel_requested = false;
	fx_spawn_sprite_follow_once(id, 0, 0, "lyr_pfx_foreground", spr_fx_float_burst, face_horizontal, 1, 0, 18);
	state = PlayerState.float;
	image_system_setup(sprite_float, ANIMATION_FPS_DEFAULT, true, true, 5, IMAGE_LOOP_FULL);
	return true;
}

function player_dive_spring_state_fail(){
	velocity.Set(0, 0);
	acceleration.Set(0, 0);

	if(sprite_current != sprite_dive_spring_fail){
		image_system_setup(sprite_dive_spring_fail, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
		image_set_frame(image, dive_spring_fail_start_frame);
	}

	if(!image.animate){
		player_dive_spring_restore_movement();
		state = PlayerState.move;
		if(move_grounded){
			image_system_setup(sprite_idle, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
		}
		else{
			image_system_setup(sprite_fall, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
		}
	}
}

function player_dive_spring_begin_impact(){
	dive_spring_phase = DiveSpringPhase.impact;
	dive_spring_impact_timer = 0;
	dive_spring_move_input_previous = input_move_magnitude;
	dive_spring_dive_timer = 0;
	velocity.Set(0, 0);
	acceleration.Set(0, 0);
	image_system_setup(sprite_dive_spring, ANIMATION_FPS_DEFAULT, true, true, dive_spring_impact_loop_start_frame, dive_spring_impact_loop_end_frame);
	image_set_frame(image, dive_spring_impact_start_frame);
	fx_spawn_sprite_once(x, y, "lyr_pfx_foreground", sprite_dive_spring_effect_lines, image_xscale, image_yscale, 0, ANIMATION_FPS_DEFAULT);
	if(move_grounded || (collision.y != 0)){
		landing_smoke_armed = false;
		fx_spawn_sprite_once(x, bbox_bottom, "lyr_pfx_foreground", spr_fx_smoke_landing, 1, 1, 0, 18);
	}

	if(player_dive_spring_jump_pressed()){
		player_dive_spring_resolve_jump_timing();
	}
}

function player_dive_spring_begin_spring(){
	dive_spring_phase = DiveSpringPhase.spring;
	dive_spring_impact_timer = 0;
	dive_spring_move_input_previous = 0;
	dive_spring_dive_timer = 0;
	dive_spring_launch_hold_time = dive_spring_launch_hold_time_max;
	dive_spring_launch_impulse_pending = true;
	dive_spring_apex_reached = false;
	move_gravity_factor = 1;
	velocity.Set(0, 0);
	acceleration.Set(0, 0);
	move_gravity.Copy(move_gravity_rise);
	jump_hold_allow_countdown = 0;
	dash_stamina = dash_stamina_max;
	dash_stamina_depleted = false;
	float_countdown = float_countdown_max;
	with(o_camera){
		if(follow_jump_dampening_enable){
			follow_jump_dampening_factor = 1;
		}
	}
	image_system_setup(sprite_dive_spring, 0, false, false, 0, IMAGE_LOOP_FULL);
	image_set_frame(image, dive_spring_launch_frame);
}

function player_dive_spring_begin_fail(){
	dive_spring_phase = DiveSpringPhase.fail;
	dive_spring_move_input_previous = 0;
	dive_spring_dive_timer = 0;
	dive_spring_startup_animation_active = false;
	dive_spring_launch_hold_time = 0;
	dive_spring_launch_impulse_pending = false;
	dive_spring_apex_reached = false;
	dive_spring_float_cancel_requested = false;
	dive_spring_dash_cancel_requested = false;
	velocity.Set(0, 0);
	acceleration.Set(0, 0);
	image_system_setup(sprite_dive_spring_fail, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
	image_set_frame(image, dive_spring_fail_start_frame);
}

function player_dive_spring_register_impact(){
	dive_spring_enemy_impact = true;
}

function player_dive_spring_restore_movement(){
	if(dive_spring_movement_override_active){
		velocity_retention_aerial = dive_spring_velocity_retention_aerial_previous;
		dive_spring_movement_override_active = false;
	}
}

function player_dive_spring_reset(){
	player_dive_spring_restore_movement();
	move_gravity_factor = 1;
	dive_spring_phase = DiveSpringPhase.dive;
	dive_spring_impact_timer = 0;
	dive_spring_move_input_previous = 0;
	dive_spring_dive_timer = 0;
	dive_spring_startup_animation_active = false;
	dive_spring_launch_hold_time = 0;
	dive_spring_launch_impulse_pending = false;
	dive_spring_apex_reached = false;
	dive_spring_enemy_impact = false;
	dive_spring_float_cancel_requested = false;
	dive_spring_dash_cancel_requested = false;
}

function player_dive_spring_float_input_active(){
	return input_current[UserControl.float] || keyboard_check(vk_up);
}

function player_animation_frame_transfer(_target_sprite){
	var _source_sprite, _source_frame_max, _target_frame_max;
	_source_sprite = sprite_current;

	if((_source_sprite == noone) || (_target_sprite == noone)){
		return 0;
	}

	_source_frame_max = max(1, sprite_get_number(_source_sprite) - 1);
	_target_frame_max = max(1, sprite_get_number(_target_sprite) - 1);

	return round(clamp(floor(sprite_current_frame), 0, _source_frame_max) / _source_frame_max * _target_frame_max);
}

function player_frolic_begin_sprite(){
	var _transition_sprite;
	_transition_sprite = noone;
	var _transition_sprite_followup;
	_transition_sprite_followup = noone;

	if(sprite_current == sprite_walk){
		_transition_sprite = sprite_transition_walk_to_frolic;
	}
	else if(sprite_current == sprite_idle){
		_transition_sprite = sprite_transition_idle_to_frolic;
		_transition_sprite_followup = sprite_transition_walk_to_frolic;
	}

	image_system_setup(sprite_frolic, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);

	if(_transition_sprite != noone){
		image_system_queue_add_to_front(_transition_sprite, ANIMATION_FPS_DEFAULT);
	}
	if(_transition_sprite_followup != noone){
		image_system_queue_add_to_back(_transition_sprite_followup, ANIMATION_FPS_DEFAULT);
	}
}

function player_frolic_end_to_walk(){
	var _target_frame;
	_target_frame = 0;

	if(sprite_current == sprite_frolic){
		_target_frame = player_animation_frame_transfer(sprite_walk);
	}

	image_system_setup(sprite_walk, ANIMATION_FPS_DEFAULT, true, true, 4, IMAGE_LOOP_FULL);
	image_set_frame(image, _target_frame);
}

#macro PLAYER_SECRET_IDLE_PHASE_INACTIVE 0
#macro PLAYER_SECRET_IDLE_PHASE_SITDOWN 1
#macro PLAYER_SECRET_IDLE_PHASE_INTRO 2
#macro PLAYER_SECRET_IDLE_PHASE_LOOP 3

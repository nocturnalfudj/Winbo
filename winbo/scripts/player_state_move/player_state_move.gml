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

		if((input_current[UserControl.float]) || (keyboard_check(vk_up))){
			if((float_countdown > 0) && (!move_grounded)){
				if((acceleration.y >= 0) && (velocity.y >= 0)){
					player_frolic_clear();
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
		if((input_current[UserControl.jump]) && (!input_previous[UserControl.jump])){
			var _close_enough_to_jump;
			_close_enough_to_jump = false;

			if(move_grounded_close){
				if(velocity.y > 0){
					_close_enough_to_jump = true;
				}
			}

			if((bump_jump_count) || (move_grounded) || (_close_enough_to_jump)){
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

				if(quick_smoke_fx_enable){
					var _jump_smoke_sprite, _jump_smoke_xscale;
					_jump_smoke_sprite = (input_move_magnitude > 0.1) ? spr_smoke_jump_diagonal : spr_smoke_jump_upward;
					_jump_smoke_xscale = 1;

					if(input_move_magnitude > 0.1){
						_jump_smoke_xscale = (input_move_direction > 90 && input_move_direction < 270) ? 1 : -1;
					}

					fx_spawn_sprite_once(x, bbox_bottom, "lyr_pfx_foreground", _jump_smoke_sprite, _jump_smoke_xscale, 1, 0, ANIMATION_FPS_DEFAULT);
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
	player_movement_update();

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
	player_frolic_clear();
	player_air_spin_begin_sprite();
}

function player_air_spin_clear(){
	air_spin_active = false;
}

function player_air_spin_update_state(){
	if(!air_spin_active){
		return false;
	}

	if(move_grounded){
		player_air_spin_clear();
		return false;
	}

	if((sprite_current == sprite_air_spin) && (sprite_current_frame >= (image.sprite_number - 1))){
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
	dive_spring_input_window_countdown = 0;
	dive_spring_enemy_impact = false;
	dive_spring_momentum_x = velocity.x;
	dive_spring_velocity_retention_aerial_previous = velocity_retention_aerial;
	dive_spring_movement_override_active = true;
	velocity_retention_aerial = dive_spring_velocity_retention_aerial;

	if(velocity.y < dive_spring_dive_speed){
		velocity.y = dive_spring_dive_speed;
	}

	image_system_setup(sprite_dive_spring, ANIMATION_FPS_DEFAULT, true, true, 2, 4);
	image_set_frame(image, 0);
	return true;
}

function player_state_dive_spring(){
	player_input();
	character_health();

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
	dive_spring_enemy_impact = false;

	if(sprite_current != sprite_dive_spring){
		image_system_setup(sprite_dive_spring, ANIMATION_FPS_DEFAULT, true, true, 2, 4);
		image_set_frame(image, 0);
	}

	velocity.x = dive_spring_momentum_x;
	acceleration.x = 0;

	if(velocity.y < dive_spring_dive_speed){
		velocity.y = dive_spring_dive_speed;
	}

	acceleration.y = max(acceleration.y, dive_spring_dive_acceleration);

	player_movement_update();
	player_collisions();

	if((state != PlayerState.dive_spring) || (dive_spring_phase != DiveSpringPhase.dive)){
		return;
	}

	if(dive_spring_enemy_impact || move_grounded || (collision.x != 0) || (collision.y != 0)){
		player_dive_spring_begin_impact();
	}
}

function player_dive_spring_state_impact(){
	var _up_pressed;
	_up_pressed = (input_current[UserControl.up] && !input_previous[UserControl.up]) || keyboard_check_pressed(vk_up);

	velocity.Set(0, 0);
	acceleration.Set(0, 0);

	if(sprite_current != sprite_dive_spring){
		image_system_setup(sprite_dive_spring, ANIMATION_FPS_DEFAULT, false, false, 0, IMAGE_LOOP_FULL);
	}

	image_set_frame(image, 4);

	if(_up_pressed){
		player_dive_spring_begin_spring();
		return;
	}

	dive_spring_input_window_countdown -= global.delta_time_factor_scaled;
	if(dive_spring_input_window_countdown <= 0){
		player_dive_spring_begin_fail();
	}
}

function player_dive_spring_state_spring(){
	if(sprite_current != sprite_dive_spring){
		image_system_setup(sprite_dive_spring, ANIMATION_FPS_DEFAULT, true, true, 8, 12);
		image_set_frame(image, 8);
	}

	move_gravity.Copy(move_gravity_rise);
	player_movement_update();
	player_collisions();

	if(state != PlayerState.dive_spring){
		return;
	}

	if(velocity.y >= 0){
		dive_spring_phase = DiveSpringPhase.transition;
		image_system_setup(sprite_dive_spring, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
		image_set_frame(image, 12);
	}
}

function player_dive_spring_state_transition(){
	player_movement_update();
	player_collisions();

	if(state != PlayerState.dive_spring){
		return;
	}

	if(!image.animate){
		player_dive_spring_restore_movement();
		state = PlayerState.move;
		image_system_setup(sprite_fall_sideways, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
	}
}

function player_dive_spring_state_fail(){
	velocity.Set(0, 0);
	acceleration.Set(0, 0);

	if(sprite_current != sprite_dive_spring_fail){
		image_system_setup(sprite_dive_spring_fail, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
		image_set_frame(image, 0);
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
	dive_spring_input_window_countdown = dive_spring_input_window_max;
	velocity.Set(0, 0);
	acceleration.Set(0, 0);
	image_system_setup(sprite_dive_spring, ANIMATION_FPS_DEFAULT, false, false, 0, IMAGE_LOOP_FULL);
	image_set_frame(image, 4);
}

function player_dive_spring_begin_spring(){
	dive_spring_phase = DiveSpringPhase.spring;
	dive_spring_input_window_countdown = 0;
	player_dive_spring_restore_movement();
	move_grounded = false;
	move_grounded_instance = noone;
	velocity.y = min(velocity.y, 0);
	acceleration.Set(0, 0);
	acceleration.AddMagnitudeDirection(input_move_acceleration_jump * dive_spring_jump_acceleration_factor, 90);
	move_gravity.Copy(move_gravity_rise);
	dash_stamina = dash_stamina_max;
	dash_stamina_depleted = false;
	float_countdown = float_countdown_max;
	image_system_setup(sprite_dive_spring, ANIMATION_FPS_DEFAULT, true, true, 8, 12);
	image_set_frame(image, 8);
}

function player_dive_spring_begin_fail(){
	dive_spring_phase = DiveSpringPhase.fail;
	velocity.Set(0, 0);
	acceleration.Set(0, 0);
	image_system_setup(sprite_dive_spring_fail, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
	image_set_frame(image, 0);
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
	dive_spring_phase = DiveSpringPhase.dive;
	dive_spring_input_window_countdown = 0;
	dive_spring_enemy_impact = false;
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
	var _target_frame;
	_target_frame = 0;

	if(sprite_current == sprite_walk){
		_target_frame = player_animation_frame_transfer(sprite_frolic);
	}

	image_system_setup(sprite_frolic, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
	image_set_frame(image, _target_frame);
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

if(global.game_state != GameState.play) exit;

opening_cutscene_layout_update(o_camera.width,o_camera.height);

var _dt = min(global.delta_time,0.05) * o_master.time_scale * o_master.time_effect_scale;

switch(phase) {
	case OpeningCutscenePhase.intro:
		var _intro_dt = _dt;
		if(intro_preroll_elapsed < intro_preroll_duration) {
			var _preroll_remaining = intro_preroll_duration - intro_preroll_elapsed;
			var _preroll_dt = min(_intro_dt,_preroll_remaining);
			intro_preroll_elapsed += _preroll_dt;
			_intro_dt -= _preroll_dt;
			soldier_frame = (soldier_frame + soldier_fps * _preroll_dt)
				mod intro_preroll_frame_count;
			if(intro_preroll_elapsed >= intro_preroll_duration) soldier_frame = 0;
		}

		soldier_frame = min(beg_frame_first,soldier_frame + soldier_fps * _intro_dt);

		if(soldier_frame >= player_entry_frame_first && !player_entry_motion_complete) {
			player_entry_walk_elapsed += _dt;
			var _entry_target_x = camera_fixed_x + player_handoff_x;
			var _entry_remaining = _entry_target_x - player_entry_x;
			var _entry_movement_delta = global.delta_time_factor_scaled;
			var _entry_retention = power(
				player_entry_velocity_retention,
				_entry_movement_delta
			);
			var _entry_stopping_distance = player_entry_velocity * _entry_movement_delta
				/ (1 - _entry_retention);
			var _entry_acceleration = (_entry_remaining > _entry_stopping_distance)
				? player_entry_move_acceleration
				: 0;
			player_entry_x += (
				player_entry_velocity
					+ _entry_acceleration * 0.5 * _entry_movement_delta
			) * _entry_movement_delta;
			player_entry_velocity = (
				player_entry_velocity
					+ _entry_acceleration * _entry_movement_delta
			) * _entry_retention;

			if(_entry_acceleration == 0 && player_entry_velocity <= player_entry_stop_speed) {
				player_entry_x = _entry_target_x;
				player_entry_velocity = 0;
				player_entry_motion_complete = true;
				player_entry_idle_elapsed = 0;
			}
		}
		else if(player_entry_motion_complete) {
			player_entry_idle_elapsed += _dt;
		}

		if(player_entry_motion_complete
		&& soldier_frame >= soldier_notice_frame
		&& !dialogue_played) {
			enemy_voice_play(id,snd_opening_cutscene_npc_dialogue,false);
			dialogue_played = true;
		}

		if(soldier_frame >= beg_frame_first && player_entry_motion_complete) {
			phase = OpeningCutscenePhase.interactive;
			prompt_elapsed = 0;
			opening_cutscene_prompt_update();
			if(instance_number(o_player) > 0) {
				var _player = instance_find(o_player,0);
				_player.x = camera_fixed_x + player_handoff_x;
				_player.y = player_ground_y;
				_player.velocity.Set(0,0);
				_player.acceleration.Set(0,0);
				with(_player) {
					player_secret_idle_cancel(false);
					player_stage_entrance_finish();
				}
				_player.hp_vulnerable = player_hp_vulnerable_restore;
				_player.user.hp_vulnerable = player_user_hp_vulnerable_restore;
				_player.visible = true;
				var _limit_left = camera_fixed_x + player_screen_bound_margin;
				var _limit_right = camera_fixed_x + scene_width
					- player_screen_bound_margin;
				with(_player) {
					movement_limit_enable_x(_limit_left,_limit_right);
				}
				with(soldier_solid_id) {
					collision_enable_x_in = true;
					collision_enable_x_left = true;
					collision_enable_x_right = true;
					collision_enable_y_in = true;
					collision_enable_y_up = true;
					collision_enable_y_down = true;
				}
				var _player_transform = _player.transform[TransformType.anchor];
				transform_set(_player_transform,TransformValue.x,_player.x,false);
				transform_set(_player_transform,TransformValue.y,_player.y,false);
				player_bottom_previous = _player.bbox_bottom;

			}
		}
	break;

	case OpeningCutscenePhase.interactive:
		prompt_elapsed += _dt;
		opening_cutscene_prompt_update();
		player_entry_idle_elapsed += _dt;
		soldier_frame += soldier_fps * _dt;
		if(soldier_frame >= beg_frame_last + 1) soldier_frame = beg_frame_first;

		if(instance_number(o_player) > 0) {
			var _player = instance_find(o_player,0);
			var _player_bottom = _player.bbox_bottom;
			var _landed_on_soldier = _player.move_grounded_instance == soldier_solid_id
				|| (_player.collision.y == 1
					&& _player.move_collision_object_instance == soldier_solid_id);
			var _stomped = _landed_on_soldier
				&& player_bottom_previous <= soldier_solid_top + 4;

			if(_stomped) {
				with(soldier_solid_id) {
					collision_enable_x_in = false;
					collision_enable_x_left = false;
					collision_enable_x_right = false;
					collision_enable_y_in = false;
					collision_enable_y_up = false;
					collision_enable_y_down = false;
				}
				phase = OpeningCutscenePhase.defeat;
				soldier_frame = defeat_frame_first;
				defeat_elapsed = 0;
				opening_cutscene_sfx_stop(voice_snd_id);
				voice_snd_id = noone;
				enemy_voice_play(id,snd_opening_cutscene_npc_death_scream,false);
				stomp_smoke_pending = true;
				stomp_smoke_delay_elapsed = 0;
				stomp_smoke_frame = -1;
				var _exit_limit_left = camera_fixed_x + player_screen_bound_margin;
				var _exit_limit_right = room_width;
				with(_player) {
					movement_limit_enable_x(_exit_limit_left,_exit_limit_right);
					acceleration.Set(0,0);
					velocity.Set(0,0);
					acceleration.AddMagnitudeDirection(
						input_move_acceleration_jump * enemy_bounce_acceleration_factor,
						90
					);
					move_gravity.Copy(move_gravity_rise);
					player_air_spin_start();
					dash_stamina = dash_stamina_max;
					dash_stamina_depleted = false;
				}
			}
			else {
				player_bottom_previous = _player_bottom;
			}
		}
	break;

	case OpeningCutscenePhase.defeat:
		defeat_elapsed = min(defeat_duration,defeat_elapsed + _dt);
		soldier_frame = defeat_frame_first + min(
			defeat_frame_last - defeat_frame_first,
			floor(defeat_elapsed * soldier_fps)
		);
		if(defeat_elapsed >= defeat_duration) {
			phase = OpeningCutscenePhase.exit;
		}
	break;

	case OpeningCutscenePhase.exit:
		soldier_frame = defeat_frame_last;
	break;

	case OpeningCutscenePhase.title:
		soldier_frame = defeat_frame_last;
		title_elapsed = min(title_duration,title_elapsed + _dt);
	break;
}

if(stomp_smoke_pending) {
	if(stomp_smoke_frame < 0) {
		stomp_smoke_delay_elapsed += _dt;
		if(stomp_smoke_delay_elapsed >= defeat_sequence_duration) {
			stomp_smoke_frame = 0;
			audio_enemy_stomp_poof_play();
		}
	}
	else {
		stomp_smoke_frame += stomp_smoke_fps * _dt;
		if(stomp_smoke_frame >= sprite_get_number(spr_smoke_explosion_large)) {
			stomp_smoke_pending = false;
		}
	}
}

if(phase == OpeningCutscenePhase.exit
&& instance_number(o_player) > 0
&& !transition_requested) {
	var _player_exit = instance_find(o_player,0);
	var _exit_x = camera_fixed_x + scene_width;
	if(_player_exit.bbox_left >= _exit_x) {
		phase = OpeningCutscenePhase.title;
		title_elapsed = 0;
		title_player_lock_x = _player_exit.x;
		title_player_lock_y = _player_exit.y;
		_player_exit.velocity.Set(0,0);
		_player_exit.acceleration.Set(0,0);
		if(ambience_snd_id != noone) {
			opening_cutscene_sfx_stop(ambience_snd_id);
			ambience_snd_id = noone;
		}
	}
}

if(phase == OpeningCutscenePhase.title
&& (!title_card_enabled || title_elapsed >= title_duration)
&& !transition_requested) {
	level_select_unlock("tutorial");
	transition_requested = level_select_start("tutorial");
}

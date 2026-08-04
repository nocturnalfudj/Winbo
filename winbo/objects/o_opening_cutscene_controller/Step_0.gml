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
			soldier_frame = (soldier_frame + soldier_fps * _preroll_dt) mod intro_preroll_frame_count;
			if(intro_preroll_elapsed >= intro_preroll_duration) soldier_frame = 0;
		}

		var _soldier_frame_previous = soldier_frame;
		soldier_frame = min(beg_frame_first,soldier_frame + soldier_fps * _intro_dt);
		if(!dialogue_played
		&& _soldier_frame_previous < dialogue_cue_frame
		&& soldier_frame >= dialogue_cue_frame) {
			enemy_voice_play(id,snd_opening_cutscene_npc_dialogue,false);
			dialogue_played = true;
		}
		if(soldier_frame >= beg_frame_first) {
			phase = OpeningCutscenePhase.interactive;
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
				var _player_transform = _player.transform[TransformType.anchor];
				transform_set(_player_transform,TransformValue.x,_player.x,false);
				transform_set(_player_transform,TransformValue.y,_player.y,false);
			}
		}
	break;

	case OpeningCutscenePhase.interactive:
		soldier_frame += soldier_fps * _dt;
		if(soldier_frame >= beg_frame_last + 1) soldier_frame = beg_frame_first;

		if(instance_number(o_player) > 0) {
			var _player = instance_find(o_player,0);
			var _jump_pressed = _player.input_current[UserControl.jump]
				&& !_player.input_previous[UserControl.jump];

			if(_jump_pressed) {
				phase = OpeningCutscenePhase.stomp;
				stomp_elapsed = 0;

				_player.velocity.Set(0,0);
				_player.acceleration.Set(0,0);
				_player.state = PlayerState.stage_entrance;
				_player.hp_vulnerable = false;
				_player.user.hp_vulnerable = false;
			}
		}
	break;

	case OpeningCutscenePhase.stomp:
		soldier_frame += soldier_fps * _dt;
		if(soldier_frame >= beg_frame_last + 1) soldier_frame = beg_frame_first;
		stomp_elapsed = min(stomp_duration,stomp_elapsed + _dt);

		if(stomp_elapsed >= stomp_duration && instance_number(o_player) > 0) {
			var _player = instance_find(o_player,0);
			_player.x = stomp_player_target_x;
			_player.y = stomp_player_target_y;
			var _player_transform = _player.transform[TransformType.anchor];
			transform_set(_player_transform,TransformValue.x,_player.x,false);
			transform_set(_player_transform,TransformValue.y,_player.y,false);

			phase = OpeningCutscenePhase.defeat;
			soldier_frame = defeat_frame_first;
			defeat_elapsed = 0;
			opening_cutscene_sfx_stop(voice_snd_id);
			voice_snd_id = noone;
			enemy_voice_play(id,snd_opening_cutscene_npc_death_scream,false);
			stomp_smoke_pending = true;
			stomp_smoke_delay_elapsed = 0;
			with(_player) {
				acceleration.Set(0,0);
				velocity.Set(0,0);
				move_grounded = false;
				dash_stamina = dash_stamina_max;
				dash_stamina_depleted = false;
			}
		}
	break;

	case OpeningCutscenePhase.defeat:
		defeat_elapsed = min(defeat_duration,defeat_elapsed + _dt);
		soldier_frame = defeat_frame_first + min(
			defeat_frame_last - defeat_frame_first,
			floor(defeat_elapsed * soldier_fps)
		);
		if(defeat_elapsed >= defeat_duration && !stomp_smoke_pending) {
			phase = OpeningCutscenePhase.landing;
			landing_elapsed = 0;
			exit_player_x = stomp_player_target_x;
		}
	break;

	case OpeningCutscenePhase.landing:
		soldier_frame = defeat_frame_last;
		landing_elapsed = min(landing_duration,landing_elapsed + _dt);
		if(landing_elapsed >= landing_duration) {
			phase = OpeningCutscenePhase.exit;
			exit_elapsed = 0;
			exit_player_velocity = 0;
			exit_player_x = stomp_player_target_x;
		}
	break;

	case OpeningCutscenePhase.exit:
		soldier_frame = defeat_frame_last;
		exit_elapsed += _dt;
		var _movement_delta = global.delta_time_factor_scaled;
		exit_player_x += (
			exit_player_velocity
			+ exit_move_acceleration * 0.5 * _movement_delta
		) * _movement_delta;
		exit_player_velocity = (
			exit_player_velocity
			+ exit_move_acceleration * _movement_delta
		) * power(exit_velocity_retention,_movement_delta);
		if(exit_player_x >= camera_fixed_x + player_exit_x) {
			phase = OpeningCutscenePhase.title;
			title_elapsed = 0;
			if(ambience_snd_id != noone) {
				opening_cutscene_sfx_stop(ambience_snd_id);
				ambience_snd_id = noone;
			}
		}
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

if(phase == OpeningCutscenePhase.title
&& title_elapsed >= title_duration
&& !transition_requested) {
	level_select_unlock("tutorial");
	transition_requested = level_select_start("tutorial");
}

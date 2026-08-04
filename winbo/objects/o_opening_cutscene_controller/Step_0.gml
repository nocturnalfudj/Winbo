if(global.game_state != GameState.play) exit;

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
				stomp_player_start_x = _player.x;
				stomp_player_start_y = _player.y;

				var _landing_sprite = _player.sprite_fall_sideways;
				var _landing_center_x = (sprite_get_bbox_left(_landing_sprite)
					+ sprite_get_bbox_right(_landing_sprite)) * 0.5
					- sprite_get_xoffset(_landing_sprite);
				var _landing_bottom_y = sprite_get_bbox_bottom(_landing_sprite)
					- sprite_get_yoffset(_landing_sprite);
				stomp_player_target_x = camera_fixed_x + soldier_head_scene_x - _landing_center_x;
				stomp_player_target_y = camera_fixed_y + soldier_head_scene_y - _landing_bottom_y;

				_player.velocity.Set(0,0);
				_player.acceleration.Set(0,0);
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
			opening_cutscene_sfx_stop(voice_snd_id);
			voice_snd_id = noone;
			enemy_voice_play(id,snd_opening_cutscene_npc_death_scream,false);
			stomp_smoke_pending = true;
			stomp_smoke_step_count = 0;
			with(_player) {
				acceleration.Set(0,0);
				velocity.Set(0,0);
				acceleration.AddMagnitudeDirection(input_move_acceleration_jump * enemy_bounce_acceleration_factor,90);
				move_gravity.Copy(move_gravity_rise);
				move_grounded = false;
				player_air_spin_start();
				dash_stamina = dash_stamina_max;
				dash_stamina_depleted = false;
			}
		}
	break;

	case OpeningCutscenePhase.defeat:
		soldier_frame = min(defeat_frame_last,soldier_frame + soldier_fps * _dt);
		if(soldier_frame >= defeat_frame_last
		&& !stomp_smoke_pending
		&& instance_number(o_player) > 0) {
			var _player = instance_find(o_player,0);
			if(_player.move_grounded) {
				phase = OpeningCutscenePhase.exit;
				exit_player_x = _player.x;
			}
		}
	break;

	case OpeningCutscenePhase.exit:
		soldier_frame = defeat_frame_last;
		exit_player_x += exit_run_speed * _dt;
	break;
}

if(stomp_smoke_pending) {
	if(stomp_smoke_frame < 0) {
		stomp_smoke_step_count++;
		if(stomp_smoke_step_count > stomp_smoke_delay_steps) {
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

if(phase == OpeningCutscenePhase.exit && !transition_requested) {
	if(exit_player_x >= camera_fixed_x + player_exit_x) {
		level_select_unlock("tutorial");
		transition_requested = level_select_start("tutorial");
		if(transition_requested && ambience_snd_id != noone) {
			opening_cutscene_sfx_stop(ambience_snd_id);
			ambience_snd_id = noone;
		}
	}
}

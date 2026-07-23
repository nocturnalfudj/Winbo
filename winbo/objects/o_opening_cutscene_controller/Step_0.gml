if(global.game_state != GameState.play) exit;

var _dt = min(global.delta_time,0.05) * o_master.time_scale * o_master.time_effect_scale;

switch(phase) {
	case OpeningCutscenePhase.intro:
		soldier_frame = min(beg_frame_first,soldier_frame + soldier_fps * _dt);
		if(soldier_frame >= beg_frame_first) {
			phase = OpeningCutscenePhase.interactive;
			prompt_elapsed = 0;
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
				player_bottom_previous = _player.bbox_bottom - camera_fixed_y;
			}
		}
	break;

	case OpeningCutscenePhase.interactive:
		prompt_elapsed += _dt;
		soldier_frame += soldier_fps * _dt;
		if(soldier_frame >= beg_frame_last + 1) soldier_frame = beg_frame_first;

		if(instance_number(o_player) > 0) {
			var _player = instance_find(o_player,0);
			var _head_left = sequence_draw_x + 995;
			var _head_right = sequence_draw_x + 1140;
			var _head_y = sequence_draw_y + 420;
			var _player_left = _player.bbox_left - camera_fixed_x;
			var _player_right = _player.bbox_right - camera_fixed_x;
			var _player_bottom = _player.bbox_bottom - camera_fixed_y;
			var _stomped = _player.velocity.y > 0
					&& _player_right >= _head_left
					&& _player_left <= _head_right
					&& player_bottom_previous <= _head_y
					&& _player_bottom >= _head_y;

			if(_stomped) {
				phase = OpeningCutscenePhase.defeat;
				soldier_frame = defeat_frame_first;
				with(_player) {
					acceleration.Set(0,0);
					velocity.Set(0,0);
					acceleration.AddMagnitudeDirection(input_move_acceleration_jump * enemy_bounce_acceleration_factor,90);
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
		soldier_frame = min(defeat_frame_last,soldier_frame + soldier_fps * _dt);
		if(soldier_frame >= defeat_frame_last) phase = OpeningCutscenePhase.exit;
	break;

	case OpeningCutscenePhase.exit:
		soldier_frame = defeat_frame_last;
	break;
}

if(phase == OpeningCutscenePhase.exit && instance_number(o_player) > 0 && !transition_requested) {
	var _player_exit = instance_find(o_player,0);
	if(_player_exit.bbox_left >= camera_fixed_x + player_exit_x) {
		level_select_unlock("tutorial");
		transition_requested = level_select_start("tutorial");
	}
}

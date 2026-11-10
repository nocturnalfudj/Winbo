var _delta_time = global.delta_time_factor;

// A dash's hit-stop restores play when it ends, which would drop the freeze if
// the talisman was collected mid-dash. The sequence keeps the world frozen.
if((global.game_state == GameState.play) && ((phase == TalismanGotPhase.fade_to_white) || (phase == TalismanGotPhase.play))){
	game_state_set_target(GameState.cutscene);
}

switch(phase){
	case TalismanGotPhase.fade_to_white:
		// The world holds its frozen frame while the talisman artwork streams in.
		fade_time = min(fade_time + _delta_time, TALISMAN_GOT_FADE_TIME);
		var _loaded = texturegroup_load_ags(texture_group, true);
		if(_loaded && (fade_time >= TALISMAN_GOT_FADE_TIME)){
			// The video opens on white, so it picks up straight from the fade.
			video_open(TALISMAN_GOT_VIDEO_PATH);
			video_enable_loop(false);
			video_set_volume(0);
			video_opened = true;
			phase = TalismanGotPhase.play;
		}
	break;

	case TalismanGotPhase.play:
	case TalismanGotPhase.exit_to_door:
	case TalismanGotPhase.exit_in_place:
		if(video_get_status() != video_status_playing) break;
		play_time += _delta_time;

		// Loop the background just before it ends so the decoder never stops.
		if(video_get_position() >= video_get_duration() - (2000 / TALISMAN_GOT_FPS)){
			video_seek_to(TALISMAN_GOT_VIDEO_LOOP_MS);
		}

		if(phase == TalismanGotPhase.play){
			// Continue is offered once the talisman has settled into its loop.
			if(play_time >= TALISMAN_GOT_LOOP_START * SECOND / TALISMAN_GOT_FPS){
				var _continue = false;
				with(o_player){
					player_input();
					_continue = input_control_check_pressed(UserControl.jump)
						|| input_control_check_pressed(UserControl.interact)
						|| input_control_check_pressed(UserControl.attack)
						|| input_control_check_pressed(UserControl.dash)
						|| input_control_check_pressed(UserControl.float);
				}
				if(_continue || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)){
					// Fade to black on the same timing as the fade to white.
					with(o_master) master_screen_fade_begin(screen_fade_alpha, 1, TALISMAN_GOT_FADE_TIME);
					if(o_director.bonus_room_active && bonus_room_transition(o_director.bonus_room_origin)){
						phase = TalismanGotPhase.exit_to_door;
					}
					else{
						phase = TalismanGotPhase.exit_in_place;
					}
				}
			}
		}
		// Outside a bonus room there is no door to return to: resume where Winbo stands.
		else if((phase == TalismanGotPhase.exit_in_place) && !o_master.screen_fade_active){
			game_state_set_target(GameState.play);
			with(o_master) master_screen_fade_begin(screen_fade_alpha, 0, TALISMAN_GOT_FADE_TIME);
			instance_destroy();
		}
	break;
}

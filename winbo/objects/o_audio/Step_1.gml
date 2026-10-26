#region Cross-State Menu Music Guard
	// If we leave the menu by ANY route (start button, level select, dev pause level start, etc),
	// ensure the menu music is stopped. Previously this only happened via GameState.start.
	if (prev_game_state == GameState.menu && global.game_state != GameState.menu) {
		if (music_snd_id_menu != noone) {
			audio_stop_sound(music_snd_id_menu);
			music_snd_id_menu = noone;
			music_menu_skip_intro = true;
		}
	}
	prev_game_state = global.game_state;
#endregion

#region GameState Switch
	switch(global.game_state){
		case GameState.menu:
			if(music_snd_id_menu == noone && music_menu != noone){
				music_snd_id_menu = audio_sound_play(music_menu, AudioChannel.music, true, 0, 0, false, 1, 1);
				
				if(music_menu_skip_intro && music_snd_id_menu != noone){
					audio_sound_set_track_position(music_snd_id_menu, 1);
					music_menu_skip_intro = false;
				}
			}
		break;
	
		case GameState.start:
			audio_game_state_start();
		break;
		
		case GameState.gameover:
			if(music_snd_id_game != noone){
				audio_stop_sound(music_game);
				music_snd_id_game = noone;
			}
		break;
		
		case GameState.stop:
			audio_game_state_stop();
		break;
	}
#endregion

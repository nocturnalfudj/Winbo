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

#region Room-Specific Music Handling
	var _room_name = room_get_name(room);
	
	// Detect room change
	if (current_room_for_music != _room_name) {
		current_room_for_music = _room_name;
		
		// Check if this room has music defined
		if (ds_map_exists(room_music_map, _room_name)) {
			var _new_music = room_music_map[? _room_name];
			var _new_loop_start = room_music_loop_start_map[? _room_name];
			
			// If different music, switch tracks
			if (_new_music != music_game) {
				// Stop current music
				if (music_snd_id_game != noone) {
					audio_stop_sound(music_snd_id_game);
					music_snd_id_game = noone;
				}
				
				// Set new music
				music_game = _new_music;
				music_game_loop_start = _new_loop_start;
				
				// Start if in gameplay
				if (global.game_state == GameState.play || global.game_state == GameState.start) {
					music_snd_id_game = audio_sound_play(music_game, AudioChannel.music, false, 0, 1, false, 1, 1);
				}
			}
		}
		else {
			// Room has no defined music - stop current music
			if (music_snd_id_game != noone) {
				audio_stop_sound(music_snd_id_game);
				music_snd_id_game = noone;
			}
			music_game = noone;
			music_game_loop_start = 0;
		}
	}
	
	// Handle custom loop point
	if (music_snd_id_game != noone && audio_is_playing(music_snd_id_game) && music_game_loop_start > 0) {
		var _track_length = audio_sound_length(music_game);
		var _track_position = audio_sound_get_track_position(music_snd_id_game);
		
		// Loop back when near the end
		if (_track_position >= _track_length - 0.1) {
			audio_sound_set_track_position(music_snd_id_game, music_game_loop_start);
		}
	}
#endregion


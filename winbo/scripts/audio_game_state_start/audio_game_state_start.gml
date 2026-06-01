/// @desc Stops menu music and clears SFX buffers when entering gameplay
function audio_game_state_start() {
	#region Music
		#region Menu
			audio_stop_sound(music_snd_id_menu);
			music_snd_id_menu = noone;
			music_menu_skip_intro = true;
		#endregion
	#endregion

	sound_list_clear_alarm_time = sound_list_clear_alarm_time_play;

	#region Clear SFX Channel Sound List
		var _lst,_num;
		_num = channel[AudioChannel.sfx][AudioChannelProperty.sound_num];

		if(_num > 0){
			_lst = channel[AudioChannel.sfx][AudioChannelProperty.sound_list];
		
			ds_list_clear(_lst);

			channel[AudioChannel.sfx][AudioChannelProperty.sound_num] = 0;
		}
	#endregion
}

/// @desc Resolve the gameplay music configuration for a room.
function audio_gameplay_music_resolve(_room) {
	var _music = noone;
	var _loop_start = 0;

	switch(_room){
		case r_game_level_0:
			_music = music_level_test;
			_loop_start = 3.97;
		break;

		case r_game_level_1:
			_music = music_level_2;
			_loop_start = 0;
		break;

		case r_game_level_0_bonus_a:
		case r_game_level_0_bonus_b:
		case r_game_level_1_bonus_a:
		case r_game_level_1_bonus_b:
			_music = music_bonus_room;
			_loop_start = 0;
		break;
	}

	return {
		music: _music,
		loop_start: _loop_start
	};
}

/// @desc Apply gameplay music for a transition destination room.
function audio_gameplay_music_apply(_room) {
	var _config = audio_gameplay_music_resolve(_room);
	var _new_music = _config.music;
	var _new_loop_start = _config.loop_start;
	var _has_active_music = false;

	if(music_snd_id_game != noone){
		_has_active_music = audio_is_playing(music_snd_id_game) || audio_is_paused(music_snd_id_game);
	}

	if(_new_music == noone){
		if(music_snd_id_game != noone){
			audio_stop_sound(music_snd_id_game);
		}

		music_snd_id_game = noone;
		music_game = noone;
		music_game_loop_start = 0;
		return;
	}

	var _track_changed = (music_game != _new_music) || (music_game_loop_start != _new_loop_start);

	if(_track_changed && music_snd_id_game != noone){
		audio_stop_sound(music_snd_id_game);
		music_snd_id_game = noone;
		_has_active_music = false;
	}

	music_game = _new_music;
	music_game_loop_start = _new_loop_start;

	if(!_track_changed && _has_active_music){
		return;
	}

	var _loop_track_from_start = (music_game_loop_start <= 0);
	music_snd_id_game = audio_sound_play(music_game, AudioChannel.music, _loop_track_from_start, 0, 1, false, 1, 1);
}

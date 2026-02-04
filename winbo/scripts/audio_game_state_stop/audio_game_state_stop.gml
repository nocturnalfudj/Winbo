/// @desc Stops game music and cleans channel lists when leaving gameplay
function audio_game_state_stop() {
	if(music_snd_id_game != noone){
		audio_stop_sound(music_game);
		music_snd_id_game = noone;
	}

	#region Clear Music Channel Sound List
		var _lst,_num;
		_num = channel[AudioChannel.music][AudioChannelProperty.sound_num];

		if(_num > 0){
			_lst = channel[AudioChannel.music][AudioChannelProperty.sound_list];
	
			for(var _i=0;_i<_num;_i++){
				ds_list_delete(_lst,_i);
				_num -= 1;
				_i -= 1;
			}
			channel[AudioChannel.music][AudioChannelProperty.sound_num] = _num;
		}
	#endregion

	sound_list_clear_alarm_time = sound_list_clear_alarm_time_menu;
}
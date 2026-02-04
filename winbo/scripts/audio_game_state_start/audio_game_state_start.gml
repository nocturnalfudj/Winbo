/// @desc Starts game music and clears SFX buffers when entering gameplay
function audio_game_state_start() {
	#region Music
		#region Game
			if(music_snd_id_game == noone){
				music_snd_id_game = audio_sound_play(music_game,AudioChannel.music,false,0,1,false,1,1);
			}
		#endregion
	
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
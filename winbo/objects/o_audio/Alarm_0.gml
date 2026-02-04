/// @description SFX Sound List Clear
var _lst,_num;
_num = channel[AudioChannel.sfx][AudioChannelProperty.sound_num];

if(_num > 0){
	_lst = channel[AudioChannel.sfx][AudioChannelProperty.sound_list];
	
	var _snd,_lst_pos;
	_lst_pos = 0;
	for(var _i=0;(_i<AUDIO_SOUND_LIST_CLEAR_BATCH_SIZE) && (_lst_pos<_num);_i++){
		_snd = _lst[| _lst_pos];
		if(!audio_is_playing(_snd) && (!audio_is_paused(_snd))){
			ds_list_delete(_lst,_lst_pos);
			_num -= 1;
		}
		else{
			_lst_pos++;
		}
	}

	channel[AudioChannel.sfx][AudioChannelProperty.sound_num] = _num;
}

alarm[AudioAlarm.sfx_sound_list_clear] = sound_list_clear_alarm_time;
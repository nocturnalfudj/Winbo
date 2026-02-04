/// @function audio_sound_play
/// @summary Play a sound with optional pitch randomization.
/// @param _sound     Sound asset to play.
/// @param _channel   Audio channel index.
/// @param _loop      Whether the sound loops.
/// @param _priority  Playback priority.
/// @param _gain_time Fade in time for the sound.
/// @param _mute_check Respect channel mute settings when true.
/// @param _pitch_min Minimum random pitch multiplier.
/// @param _pitch_max Maximum random pitch multiplier.
function audio_sound_play(_sound,_channel,_loop,_priority,_gain_time,_mute_check,_pitch_min,_pitch_max){
	//Immediately Return Noone if Sound is Noone
	if(_sound == noone){
		return noone;
		exit;
	}
	
	#region Default Values for Undefined
		if(is_undefined(_gain_time))
			_gain_time = 0;
	
		if(is_undefined(_mute_check))
			_mute_check = true;

		if(is_undefined(_pitch_min))
			_pitch_min = 1;
		
		if(is_undefined(_pitch_max))
			_pitch_max = 1;
	#endregion

	var _sound_id;
	_sound_id = noone;
	with(o_audio){
		var _volume,_volume_is_muted;
		_volume = channel[_channel][AudioChannelProperty.volume] * volume_master;
	
		if(_volume <= 0){
			_volume_is_muted = true;
			_gain_time = 0;
		}
		else{
			_volume_is_muted = false;
		}
	
		if((!_mute_check) || ((_mute_check) && (!_volume_is_muted))){
			_sound_id = audio_play_sound(_sound,_priority,_loop);
		
			if(_gain_time != 0){
				audio_sound_gain(_sound_id,0,0);
				audio_sound_gain(_sound_id,_volume,_gain_time);
			}
			else{
				audio_sound_gain(_sound_id,_volume,_gain_time);
			}

			var _sound_list;
			_sound_list = channel[_channel][AudioChannelProperty.sound_list];

			ds_list_add(_sound_list,_sound_id);
			//channel[_channel][AudioChannelProperty.sound_num] = ds_list_size(_sound_list);
			channel[_channel][AudioChannelProperty.sound_num] += 1;
			
			#region Pitch
				if((_pitch_min != 1) && (_pitch_max != 1)){
					audio_sound_pitch(_sound_id,random_range(0.8,1.2));
				}
			#endregion
		}
	}

	return _sound_id;
}
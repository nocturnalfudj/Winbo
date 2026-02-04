function cmd_settings_audio_volume(_subject,_argument_list) {
	var _channel,_volume;
	_channel = _argument_list[| 0];
	_volume = _argument_list[| 1];
	
	if(string_is_real(_volume)){
		_volume = real(_volume);
		if((_volume >= 0) && (_volume <= 100)){
			_volume = _volume/100;
			switch(_channel){
				case "master":
					with(o_audio){
						//Update Master Volume Value
						volume_master = _volume;
		
						//Update Volume for Sounds Playing on All Chnnels
						var _channel_vol
						for(var _i=0;_i<AudioChannel.SIZE;_i++){
							_channel_vol = channel[_i][AudioChannelProperty.volume];
							audio_channel_set_vol(_i,_channel_vol,0);
						}
						
						//Save Master Volume Value
						audio_save_master_volume();
						
						sdm("Master audio volume set to" + string(_channel_vol),LOG_COLOUR_COMMAND_SUCCESS);
					}
				break;
		
				case "music":
					with(o_audio){
						audio_channel_set_vol(AudioChannel.music,_volume,0);
					
						//Save Channel Volume Value
						audio_save_channel_volume(AudioChannel.music);
						
						sdm("Music audio volume set to" + string(_channel_vol),LOG_COLOUR_COMMAND_SUCCESS);
					}
				break;
		
				case "sfx":
					with(o_audio){
						audio_channel_set_vol(AudioChannel.sfx,_volume,0);
					
						//Save Channel Volume Value
						audio_save_channel_volume(AudioChannel.sfx);
						
						sdm("SFX audio volume set to" + string(_channel_vol),LOG_COLOUR_COMMAND_SUCCESS);
					}
				break;
		
				default:
					sdm("Argument is invalid, audio channel doesn't exist : " + _channel,LOG_COLOUR_COMMAND_ERROR);
				break;
			}
		}
		else{
			sdm("Argument is invalid, must be a number between 0 and 100: " + string(_volume),LOG_COLOUR_COMMAND_ERROR);
		}
	}
	else{
		sdm("Argument is invalid, must be a number between 0 and 100: " + _volume,LOG_COLOUR_COMMAND_ERROR);
	}
	
	
}
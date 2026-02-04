/// @function cmd_settings_audio_mute
/// @summary Command to mute or unmute audio channels.
/// @param _subject Command issuer instance.
/// @param _argument_list List containing channel name and mute toggle.
/// @returns {void}
function cmd_settings_audio_mute(_subject,_argument_list) {
	var _channel,_mute;
	_channel = _argument_list[| 0];
	_mute = _argument_list[| 1];
	
	if((string_lower(_mute) == "false") || (_mute == "0")){
		_mute = false;
	}
	else if((string_lower(_mute) == "true") || (_mute == "1")){
		_mute = true;
	}
	else{
		sdm("Toggle Argument is invalid, must be true/false or 1/0 : " + _mute,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}
	
	switch(_channel){
		case "master":
			with(o_audio){
				if(_mute){
					volume_master_ini = volume_master;
					volume_master = 0;
				}
				else{
					volume_master = volume_master_ini;
				}
	
				audio_save_master_volume();
	
				var _channel_vol
				for(var _i=0;_i<AudioChannel.SIZE;_i++){
					_channel_vol = channel[_i][AudioChannelProperty.volume];
					audio_channel_set_vol(_i,_channel_vol,0);
				}
				
				sdm("Master audio muted",LOG_COLOUR_COMMAND_SUCCESS);
			}
		break;
		
		case "music":
			var _channel = AudioChannel.music;
			
			with(o_audio){
				if(_mute){
					channel[_channel][AudioChannelProperty.volume_ini] = channel[_channel][AudioChannelProperty.volume];
					audio_channel_set_vol(_channel,0,0);
				}
				else{
					if(volume_master != 0){
						var _vol;
						_vol = channel[_channel][AudioChannelProperty.volume_ini];
						audio_channel_set_vol(_channel,_vol,0);
					}
				}

				audio_save_channel_volume(_channel);
				
				sdm("Music audio muted",LOG_COLOUR_COMMAND_SUCCESS);
			}
		break;
		
		case "sfx":
			var _channel = AudioChannel.sfx;
			
			with(o_audio){
				if(_mute){
					channel[_channel][AudioChannelProperty.volume_ini] = channel[_channel][AudioChannelProperty.volume];
					audio_channel_set_vol(_channel,0,0);
				}
				else{
					if(volume_master != 0){
						var _vol;
						_vol = channel[_channel][AudioChannelProperty.volume_ini];
						audio_channel_set_vol(_channel,_vol,0);
					}
				}

				audio_save_channel_volume(_channel);
				
				sdm("SFX audio muted",LOG_COLOUR_COMMAND_SUCCESS);
			}
		break;
		
		default:
			sdm("Argument is invalid, audio channel doesn't exist : " + _channel,LOG_COLOUR_COMMAND_ERROR);
		break;
	}
}
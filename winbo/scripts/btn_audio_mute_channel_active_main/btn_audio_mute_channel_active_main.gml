/// @desc Toggles mute for an individual audio channel when activated
function btn_audio_mute_channel_active_main() {
	var _channel = channel;

	if(toggle){
		with(o_audio){
			channel[_channel][AudioChannelProperty.volume_ini] = channel[_channel][AudioChannelProperty.volume];
		}
		
		audio_channel_set_vol(_channel,0,0);
	}
	else{
		if(o_audio.volume_master != 0){
			var _vol;
			_vol = o_audio.channel[_channel][AudioChannelProperty.volume_ini];
			audio_channel_set_vol(_channel,_vol,0);
		}
		else{
			button_toggle_set(true);
		}
	}

	with(o_audio){
		audio_save_channel_volume(_channel);
	}
}
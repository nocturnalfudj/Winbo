/// @desc Handles idle state visuals for channel mute button
function btn_audio_mute_channel_idle_main() {
	var _vol;
	_vol = o_audio.channel[channel][AudioChannelProperty.volume];

	if(_vol == 0){
		if(!toggle){
			button_toggle_set(true);
		}
	}
	else{
		if(toggle){
			button_toggle_set(false);
		}
	}
}
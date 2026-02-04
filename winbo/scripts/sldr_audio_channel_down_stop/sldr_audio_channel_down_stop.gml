function sldr_audio_channel_down_stop() {
	var _channel;
	_channel = channel;
	with(o_audio){
		//Save Channel Volume Value
		audio_save_channel_volume(_channel);
	}
}
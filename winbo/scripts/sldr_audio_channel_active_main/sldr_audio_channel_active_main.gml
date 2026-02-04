function sldr_audio_channel_active_main() {
	if(value_current != value_previous){
		audio_channel_set_vol(channel,value_current,0);
	}
}
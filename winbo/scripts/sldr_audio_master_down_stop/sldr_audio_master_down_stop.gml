function sldr_audio_master_down_stop() {
	with(o_audio){
		//Save Master Volume Value
		audio_save_master_volume();
	}
}
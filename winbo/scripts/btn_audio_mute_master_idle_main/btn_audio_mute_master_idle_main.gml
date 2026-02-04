/// @desc Updates idle visuals for the master mute button
function btn_audio_mute_master_idle_main() {
	var _vol;
	_vol = o_audio.volume_master;

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
/// @desc Toggles the master audio mute setting when activated
function btn_audio_mute_master_active_main() {
	with(o_audio){
		if(other.toggle){
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
	}
}
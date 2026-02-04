/// @function sldr_audio_master_active_main
/// @summary Apply the new master volume when the slider value changes.
function sldr_audio_master_active_main() {
	if(value_current != value_previous){
		var _value_current;
		_value_current = value_current;
	
		with(o_audio){
			//Update Master Volume Value
			volume_master = _value_current;
		
			//Update Volume for Sounds Playing on All Channels
			var _channel_vol
			for(var _i=0;_i<AudioChannel.SIZE;_i++){
				_channel_vol = channel[_i][AudioChannelProperty.volume];
				audio_channel_set_vol(_i,_channel_vol,0);
			}
		}
	}
}
/// @desc Saves the volume setting for the given audio channel to disk
/// @param channel Index of the audio channel
function audio_save_channel_volume(_channel) {
	//If Game is Running in a Browser Return -1
	if(os_browser != browser_not_a_browser)
		return -1;
		
	save("volume_" + string(_channel),channel[_channel][AudioChannelProperty.volume]);

	//ds_map_secure_save(save_map,SAVE_FILE_AUDIO);
	map_save_json(save_map,SAVE_FILE_AUDIO);
}
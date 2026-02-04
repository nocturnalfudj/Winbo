/// @function audio_load
/// @summary Load saved audio settings for volume and channels.
/// @returns {-1|undefined} Returns -1 when running in a browser.
/// @description
///   Reads the master volume and each channel volume from saved data.
function audio_load() {
	//If Game is Running in a Browser Return -1
	if(os_browser != browser_not_a_browser)
		return -1;
		
	var _save_map_val;
	bad_load = false;

	#region Channel Volume
		//Master Volume
		_save_map_val = load("volume_master");
		if(_save_map_val != undefined)
			volume_master = _save_map_val;
	
		#region Channel Volumes
			for(var _i=0;_i<AudioChannel.SIZE;_i++){
				_save_map_val = load("volume_" + string(_i));
				if(_save_map_val != undefined){
					channel[_i][AudioChannelProperty.volume] = _save_map_val;
			
					audio_channel_set_vol(_i,_save_map_val,0);
				}
			}
		#endregion
	#endregion
	
	if(bad_load == true){
		sdm(bad_load_string + "Destroying old map");
		ds_map_destroy(save_map);
		
		sdm(bad_load_string + "Creating new map");
		save_map = ds_map_create();
		
		sdm(bad_load_string + "Saving Audio");
		audio_save();
	}
}
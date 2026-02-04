/// @function audio_save
/// @summary Save current master and channel volume levels.
/// @returns {-1|undefined} Returns -1 when running in a browser.
/// @description
///   Writes audio settings to persistent storage for future sessions.
function audio_save() {
	//If Game is Running in a Browser Return -1
	if(os_browser != browser_not_a_browser)
		return -1;
		
	#region Channel Volume
		//Master Volume
		audio_save_master_volume();
	
		//Channel Volumes
		for(var _i=0;_i<AudioChannel.SIZE;_i++){
			audio_save_channel_volume(_i);
		}
	#endregion
}
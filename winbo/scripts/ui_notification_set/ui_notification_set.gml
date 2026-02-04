/// @function ui_notification_set
/// @summary Toggle and save notification flags to persistent storage.
/// @param {bool} _bool      Enable or disable the notification.
/// @param {string} _string  Key name used for saving to the UI map.
function ui_notification_set(_bool,_string) {
	notification_active = _bool;

	with(o_ui){
		var _key_str;
		_key_str = UI_SAVE_NOTIFICATION_STRING + _string;
		if(_bool){
			save_map[? _key_str] = true;
		}
		else{
			ds_map_delete(save_map,_key_str);
		}
	
		//ds_map_secure_save(save_map,SAVE_FILE_UI);
		map_save_json(save_map,SAVE_FILE_UI);
	}
}
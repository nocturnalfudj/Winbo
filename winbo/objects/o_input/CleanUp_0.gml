#region KeyCodes
	#region Keyboard	
		var _list = global.keyboard_keycode_list;
		if(ds_exists(_list,ds_type_list)){
			ds_list_destroy(_list);
			if(DEBUG_CLEANUP) sdm("Keyboard keycode list destroyed : " + string(_list));
		}
	#endregion

	#region GamePad	
		var _list = global.gamepad_keycode_list;
		if(ds_exists(_list,ds_type_list)){
			ds_list_destroy(_list);
			if(DEBUG_CLEANUP) sdm("Gamepad keycode list destroyed : " + string(_list));
		}
	#endregion
#endregion
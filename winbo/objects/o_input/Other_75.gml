if((!IS_MOBILE) && (GAMEPAD_ENABLE)){
	var _event_type;
	_event_type = ds_map_find_value(async_load, "event_type");

	#region Gamepad Event
		var _pad_index;
		_pad_index = ds_map_find_value(async_load, "pad_index");
	
		switch(_event_type){
			case "gamepad discovered":
				//Gamepad Connected
				gamepad[_pad_index].connected = true;
				sdm("gamepad discovered: " + string(_pad_index));
				
				//If No Device Set to Control UI
				if(global.gamepad_device_ui_control == -1){
					//Set the gamepad that just connected
					global.gamepad_device_ui_control = _pad_index;
					sdm("gamepad ui control set: " + string(_pad_index));
				}
				
				//Connect to First Available User (without a gamepad assigned already)
				gamepad_connect_to_first_available_user(_pad_index);
				
				sdm("");
			break;
	
			case "gamepad lost":
				//Gamepad Lost Connection
				gamepad[_pad_index].connected = false;
				sdm("gamepad lost: " + string(_pad_index));
				
				//Disconnect Gamepad From User
				gamepad_disconnect_from_user(_pad_index);
				
				//Reset Gamepad Which Controls UI
				global.gamepad_device_ui_control = -1;
				sdm("gamepad ui control disconnect: " + string(_pad_index));
				
				//Go Through All Gamepads to Find First Connected One to Control UI
				for(var _i=0;_i<GAMEPAD_DEVICE_MAX;_i++){
					if(gamepad[_i].connected){
						global.gamepad_device_ui_control = _i;
						sdm("gamepad ui control set: " + string(_i));
						break;
					}
				}
				
				sdm("");
			break;
		}
	#endregion
}
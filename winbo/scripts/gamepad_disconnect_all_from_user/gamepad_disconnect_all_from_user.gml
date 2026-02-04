/// @function gamepad_disconnect_all_from_user
/// @summary Detach all connected gamepads from their users.
function gamepad_disconnect_all_from_user(){
	//Go Through All Connected Gamepads
	for(var _i=0;_i<GAMEPAD_DEVICE_MAX;_i++){
		if(gamepad[_i].connected){
			gamepad_disconnect_from_user(_i);
		}
	}
}
/// @function gamepad_disconnect_from_user
/// @summary Remove a gamepad from its user when disconnected.
/// @param _pad_index Index of the gamepad.
/// @returns {void}
function gamepad_disconnect_from_user(_pad_index){
	//Remove Gamepad from User
	with(gamepad[_pad_index].user){
		input_device = -1;
		
		sdm("user " + string(user_id) + " input device disconnect: " + string(_pad_index));
	}
	
	//Remove User from Gamepad
	gamepad[_pad_index].user = noone;
	sdm("gamepad " + string(_pad_index) + " user disconnect");
}
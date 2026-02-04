/// @function input_save_user_gamepad_aim_assist
/// @summary Persist the gamepad aim-assist setting for the current user.
/// @param control Unused legacy parameter
function input_save_user_gamepad_aim_assist() {
	//If Game is Running in a Browser Return -1
	if(os_browser != browser_not_a_browser)
		return -1;

	var _save_map,_map_key_string,_value;
	_save_map = o_input.save_map;

	_map_key_string = "user_" + string(user_id) + "_gamepad_aim_assist";
	_value = gamepad_aim_assist;
	_save_map[? _map_key_string] = _value;

	//ds_map_secure_save(_save_map,SAVE_FILE_INPUT);

	map_save_json(_save_map,SAVE_FILE_INPUT);
}
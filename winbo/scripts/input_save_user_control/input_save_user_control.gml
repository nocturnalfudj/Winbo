///@param control
function input_save_user_control(_control) {
	//If Game is Running in a Browser Return -1
	if(os_browser != browser_not_a_browser)
		return -1;
		
	var _save_map,_map_key_string,_value;
	_save_map = o_input.save_map;
	
	_map_key_string = "user_" + string(user_id) + "_control_" + string(_control) + "_gamepad"
	_value = control[_control].input[Input.gamepad][InputProperty.key];
	_save_map[? _map_key_string] = _value;
	
	_map_key_string = "user_" + string(user_id) + "_control_" + string(_control) + "_keyboard";
	_value = control[_control].input[Input.keyboard][InputProperty.key];
	_save_map[? _map_key_string] = _value;
	
	_map_key_string = "user_" + string(user_id) + "_control_" + string(_control) + "_mouse";
	_value = control[_control].input[Input.mouse][InputProperty.key];
	_save_map[? _map_key_string] = _value;
	
	_map_key_string = "user_" + string(user_id) + "_control_" + string(_control) + "_mouse_and_keyboard";
	_value = control[_control].input[Input.mouse_and_keyboard][InputProperty.key];
	_save_map[? _map_key_string] = _value;

	//ds_map_secure_save(_save_map,SAVE_FILE_INPUT);
	
	map_save_json(_save_map,SAVE_FILE_INPUT);
}
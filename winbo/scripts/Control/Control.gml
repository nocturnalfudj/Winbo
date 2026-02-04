/// @function Control
/// @summary Stores mapping info for a control across input methods.
/// @param _control   Custom control identifier.
/// @param _name      Display label used in UI.
/// @param _key_gamepad Key bound on gamepads.
/// @param _key_mouse_and_keyboard Key for combined mouse and keyboard.
/// @param _key_mouse Key for mouse-only input.
/// @param _key_keyboard Key for keyboard-only input.
/// @returns {struct} Control mapping struct.
/// @description
///   Create a new mapping entry for an input action. The resulting
///   struct can be stored in a list and queried when processing input.
function Control(_control,_name,_key_gamepad,_key_mouse_and_keyboard,_key_mouse,_key_keyboard) constructor{
	control = _control;
	name = _name;
	
	//Gamepad
	input[Input.gamepad][InputProperty.key] = _key_gamepad;
	input[Input.gamepad][InputProperty.sprite] = ds_list_find_value(global.gamepad_sprite_list,_key_gamepad);
	
	//Mouse & Keyboard
	input[Input.mouse_and_keyboard][InputProperty.key] = _key_mouse_and_keyboard;
	if((_key_mouse_and_keyboard == mb_left) || _key_mouse_and_keyboard == mb_right || _key_mouse_and_keyboard == mb_middle)
		input[Input.mouse_and_keyboard][InputProperty.sprite] = ds_list_find_value(global.mouse_sprite_list,_key_mouse_and_keyboard);
	else
		input[Input.mouse_and_keyboard][InputProperty.sprite] = ds_list_find_value(global.keyboard_sprite_list,_key_mouse_and_keyboard);
	
	//Mouse
	input[Input.mouse][InputProperty.key] = _key_mouse;
	input[Input.mouse][InputProperty.sprite] = ds_list_find_value(global.mouse_sprite_list,_key_mouse);
	
	//Keyboard
	input[Input.keyboard][InputProperty.key] = _key_keyboard;
	input[Input.keyboard][InputProperty.sprite] = ds_list_find_value(global.keyboard_sprite_list,_key_keyboard);
}
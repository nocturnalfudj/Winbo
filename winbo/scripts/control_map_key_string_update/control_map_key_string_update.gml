function control_map_key_string_update() {
	key_string = "UNDEFINED KEY!";
	switch(input){
		case Input.mouse_and_keyboard:
			if((key == mb_left) || key == mb_right)
				key_string = ds_list_find_value(global.mouse_keycode_list,key);
			else
				key_string = ds_list_find_value(global.keyboard_keycode_list,key);
		break;
	
		case Input.gamepad:
			key_string = ds_list_find_value(global.gamepad_keycode_list,key);
		break;
	}
}
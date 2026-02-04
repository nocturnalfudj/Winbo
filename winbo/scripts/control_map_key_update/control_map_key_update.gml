/// @function control_map_key_update
/// @summary Refresh display strings and sprites for a mapped key.
function control_map_key_update() {
	key_string = "UNDEFINED KEY!";
	
	var _control,_key,_sprite;
	_control = control;
	
	switch(input){
		case Input.keyboard:
			switch(control_type){
				case ControlType.app:
					with(o_input){
						_key = app_control[_control].input[Input.keyboard][InputProperty.key];
						_sprite = app_control[_control].input[Input.keyboard][InputProperty.sprite];
					}
				break;
				
				case ControlType.user:
					with(user){
						_key = control[_control].input[Input.keyboard][InputProperty.key];
						_sprite = control[_control].input[Input.keyboard][InputProperty.sprite];
					}
				break;
			}
			
			key = _key;
			key_sprite = _sprite;
			key_string = ds_list_find_value(global.keyboard_keycode_list,key);
		break;
	
		case Input.mouse:
			switch(control_type){
				case ControlType.app:
					with(o_input){
						_key = app_control[_control].input[Input.mouse][InputProperty.key];
						_sprite = app_control[_control].input[Input.mouse][InputProperty.sprite];
					}
				break;
				
				case ControlType.user:
					with(user){
						_key = control[_control].input[Input.mouse][InputProperty.key];
						_sprite = control[_control].input[Input.mouse][InputProperty.sprite];
					}
				break;
			}
			
			key = _key;
			key_sprite = _sprite;
			key_string = ds_list_find_value(global.mouse_keycode_list,key);
		break;
	
		case Input.mouse_and_keyboard:
			switch(control_type){
				case ControlType.app:
					with(o_input){
						_key = app_control[_control].input[Input.mouse_and_keyboard][InputProperty.key];
						_sprite = app_control[_control].input[Input.mouse_and_keyboard][InputProperty.sprite];
					}
				break;
				
				case ControlType.user:
					with(user){
						_key = control[_control].input[Input.mouse_and_keyboard][InputProperty.key];
						_sprite = control[_control].input[Input.mouse_and_keyboard][InputProperty.sprite];
					}
				break;
			}
			
			key = _key;
			key_sprite = _sprite;
		
			if((key == mb_left) || key == mb_right || key == mb_middle)
				key_string = ds_list_find_value(global.mouse_keycode_list,key);
			else
				key_string = ds_list_find_value(global.keyboard_keycode_list,key);
		break;
	
		case Input.gamepad:
			switch(control_type){
				case ControlType.app:
					with(o_input){
						_key = app_control[_control].input[Input.gamepad][InputProperty.key];
						_sprite = app_control[_control].input[Input.gamepad][InputProperty.sprite];
					}
				break;
				
				case ControlType.user:
					with(user){
						_key = control[_control].input[Input.gamepad][InputProperty.key];
						_sprite = control[_control].input[Input.gamepad][InputProperty.sprite];
					}
				break;
			}
			
			key = _key;
			key_sprite = _sprite;
			key_string = ds_list_find_value(global.gamepad_keycode_list,key);
		break;
	}

	if(key_sprite == -1){
		key_sprite = noone;
	}
}
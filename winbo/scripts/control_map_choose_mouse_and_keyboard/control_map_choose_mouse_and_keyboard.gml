/// @function control_map_choose_mouse_and_keyboard
/// @summary Choose an input key or mouse button for a control mapping.
/// @returns {void}
/// Call this from a UI element to allow the player to remap controls.
function control_map_choose_mouse_and_keyboard() {
	var _key,_keyboard_string,_keyboard_string_length,_keyTxt,_valid_key;
	_key = keyboard_lastkey;
	_keyboard_string = keyboard_string;
	_keyboard_string_length = string_length(_keyboard_string)
	_valid_key = false;

	if((_keyboard_string_length > 0) && (_keyboard_string != " ")){
		_keyTxt = string_copy(_keyboard_string,_keyboard_string_length,1);
		_keyTxt = string_upper(_keyTxt);
		_valid_key = true;
	}
	else if(_key >= 1){
		_keyTxt = global.keyboard_keycode_list[| _key];

		//if(_keyTxt == "Escape"){
		//	//State to Idle
		//	ui_object_state_set(UIState.idle);
		//}
		//else
			_valid_key = true;
	}
	
	if(mouse_check_button_pressed(mb_left)){
		_key = mb_left;
		_valid_key = true;
	}
	else if(mouse_check_button_pressed(mb_right)){
		_key = mb_right;
		_valid_key = true;
	}
	else if(mouse_check_button_pressed(mb_middle)){
		_key = mb_middle;
		_valid_key = true;
	}

	if(_valid_key){
		var _control_conflict;
		_control_conflict = false;
		with(o_control_map){
			if((input == other.input) && (id!=other) && (key == _key))
				_control_conflict = true;
		}
	
		if(!_control_conflict){
			key = _key;
		
			//State to Idle
			ui_object_state_set(UIState.idle);
		
			//NO CONFLICT
			//txt_conflictShow = 0;
		
			var _key,_control,_sprite;
			_key = key
			_control = control
			switch(control_type){
				case ControlType.app:
					with(o_input){
						app_control[_control].input[Input.mouse_and_keyboard][InputProperty.key] = _key;
						if((_key == mb_left) || _key == mb_right || _key == mb_middle){
							_sprite = ds_list_find_value(global.mouse_sprite_list,_key);
							app_control[_control].input[Input.mouse_and_keyboard][InputProperty.sprite] = _sprite;
						}
						else{
							_sprite = ds_list_find_value(global.keyboard_sprite_list,_key);
							app_control[_control].input[Input.mouse_and_keyboard][InputProperty.sprite] = _sprite;
						}
					}
				break;
				
				case ControlType.user:
					with(user){
						control[_control].input[Input.mouse_and_keyboard][InputProperty.key] = _key;
						if((_key == mb_left) || _key == mb_right || _key == mb_middle){
							_sprite = ds_list_find_value(global.mouse_sprite_list,_key);
							control[_control].input[Input.mouse_and_keyboard][InputProperty.sprite] = _sprite;
						}
						else{
							_sprite = ds_list_find_value(global.keyboard_sprite_list,_key);
							control[_control].input[Input.mouse_and_keyboard][InputProperty.sprite] = _sprite;
						}
					}
				break;
			}
			
			//Update Key Sprite
			key_sprite = _sprite;
			if(key_sprite == -1){
				key_sprite = noone;
			}
			
			//Update Key String
			if((key == mb_left) || key == mb_right || key == mb_middle)
				key_string = ds_list_find_value(global.mouse_keycode_list,key);
			else
				key_string = ds_list_find_value(global.keyboard_keycode_list,key);
			
			if(is_undefined(key_string))
				key_string = "UNDEFINED KEY!";
		}
		else{
			//CONFLICT
			//txt_conflictShow = 1;
		}
	}

	keyboard_string = "";
	keyboard_lastkey = -1;
}
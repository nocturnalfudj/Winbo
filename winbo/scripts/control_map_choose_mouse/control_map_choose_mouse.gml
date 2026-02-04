/// @function control_map_choose_mouse
/// @summary Wait for the player to press a mouse button and return it.
/// @returns {real|noone} The button index or noone if none pressed.
function control_map_choose_mouse() {
	var _mouse_key;
	_mouse_key = noone;

	if(mouse_check_button_pressed(mb_left)){
		_mouse_key = mb_left;
	}
	else if(mouse_check_button_pressed(mb_right)){
		_mouse_key = mb_right;
	}
	else if(mouse_check_button_pressed(mb_middle)){
		_mouse_key = mb_middle;
	}

	if(_mouse_key != noone){
		var _conflict;
		_conflict = false;
		with(o_control_map){
			if((input == other.input) && (id!=other) && (key == _mouse_key))
				_conflict = true;
		}
	
		if(!_conflict){
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
						app_control[_control].input[Input.mouse][InputProperty.key] = _key;
						
						_sprite = ds_list_find_value(global.mouse_sprite_list,_key);
						app_control[_control].input[Input.mouse][InputProperty.sprite] = _sprite;
					}
				break;
				
				case ControlType.user:
					with(user){
						control[_control].input[Input.mouse][InputProperty.key] = _key;
						_sprite = ds_list_find_value(global.mouse_sprite_list,_key);
						control[_control].input[Input.mouse][InputProperty.sprite] = _sprite;
					}
				break;
			}
			
			//Update Key Sprite
			key_sprite = _sprite;
			if(key_sprite == -1){
				key_sprite = noone;
			}
			
			//Update Key String
			key_string = ds_list_find_value(global.mouse_keycode_list,key);
			if(is_undefined(key_string))
				key_string = "UNDEFINED KEY!";
		}
		else{
			//CONFLICT
			//txt_conflictShow = 1;
		}
	}
}
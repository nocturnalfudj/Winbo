function control_map_choose_gamepad() {
	var _key,_user,_user_input_device;
	_key = 0
	_user = user;
	_user_input_device = _user.input_device;
	
	if(_user_input_device != -1){
		with(o_input){
			if(gamepad[_user_input_device].connected){
				for (var _i=gp_face1;_i<=gp_padr;_i++){
					if gamepad_button_check_released(_user_input_device, _i){
						_key = _i;
					}
				}
			}
		}
	}

	if((_key != 0) && (_key!=gp_start) && (_key!=gp_select)){
		var _control_conflict = false;
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
						app_control[_control].input[Input.gamepad][InputProperty.key] = _key;
						
						_sprite = ds_list_find_value(global.gamepad_sprite_list,_key);
						app_control[_control].input[Input.gamepad][InputProperty.sprite] = _sprite;
					}
				break;
				
				case ControlType.user:
					with(user){
						control[_control].input[Input.gamepad][InputProperty.key] = _key;
						_sprite = ds_list_find_value(global.gamepad_sprite_list,_key);
						control[_control].input[Input.gamepad][InputProperty.sprite] = _sprite;
					}
				break;
			}
			
			//Update Key Sprite
			key_sprite = _sprite;
			if(key_sprite == -1){
				key_sprite = noone;
			}
			
			//Update Key String
			key_string = ds_list_find_value(global.gamepad_keycode_list,key);
			if(is_undefined(key_string))
				key_string = "UNDEFINED KEY!";
		}
		else{
			//CONFLICT
			//txt_conflictShow = 1;
		}
	}

	//Exit Choose
	var _key = keyboard_lastkey;
	if((_key != 0) && (global.keyboard_keycode_list[| _key] == "Escape")){
		//State to Idle
		ui_object_state_set(UIState.idle);
	}
} 
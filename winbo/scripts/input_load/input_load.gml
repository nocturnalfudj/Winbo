/// @function input_load
/// @summary Load saved input settings from disk.
function input_load() {
	//If Game is Running in a Browser Return -1
	if(os_browser != browser_not_a_browser)
		return -1;
		
	var _save_map_val;
	
	bad_load = false;
	
	#region Load All App Controls
		for(var _i=0;_i<AppControl.SIZE;_i++){
			#region Gamepad
				_save_map_val = load("app_control_" + string(_i) + "_gamepad");
		
				if(_save_map_val != undefined){
					app_control[_i].input[Input.gamepad][InputProperty.key] = _save_map_val;
					app_control[_i].input[Input.gamepad][InputProperty.sprite] = ds_list_find_value(global.gamepad_sprite_list,_save_map_val);
				}
			#endregion
		
			#region Keyboard
				_save_map_val = load("app_control_" + string(_i) + "_keyboard");
		
				if(_save_map_val != undefined){
					app_control[_i].input[Input.keyboard][InputProperty.key] = _save_map_val;
					app_control[_i].input[Input.keyboard][InputProperty.sprite] = ds_list_find_value(global.keyboard_sprite_list,_save_map_val);
				}
			#endregion
		
			#region Mouse
				_save_map_val = load("app_control_" + string(_i) + "_mouse");
		
				if(_save_map_val != undefined){
					app_control[_i].input[Input.mouse][InputProperty.key] = _save_map_val;
					app_control[_i].input[Input.mouse][InputProperty.sprite] = ds_list_find_value(global.mouse_sprite_list,_save_map_val);
				}
			#endregion
		
			#region Mouse & Keyboard
				_save_map_val = load("app_control_" + string(_i) + "_mouse_and_keyboard");
		
				if(_save_map_val != undefined){
					app_control[_i].input[Input.mouse_and_keyboard][InputProperty.key] = _save_map_val;
				
					if((_save_map_val == mb_left) || _save_map_val == mb_right || _save_map_val == mb_middle)
						app_control[_i].input[Input.mouse_and_keyboard][InputProperty.sprite] = ds_list_find_value(global.mouse_sprite_list,_save_map_val);
					else
						app_control[_i].input[Input.mouse_and_keyboard][InputProperty.sprite] = ds_list_find_value(global.keyboard_sprite_list,_save_map_val);
				}
			#endregion
		}
	#endregion
	
	#region Load All User Values
		var _user;
		for(var _i=0;_i<USER_NUM_MAX;_i++){
			_user = user[_i];
			
			#region Gamepad Aim Assist
				_save_map_val = load("user_" + string(_i) + "_gamepad_aim_assist");
		
				if(_save_map_val != undefined){
					_user.gamepad_aim_assist = _save_map_val;
				}
			#endregion
			
			//Controls
			for(var _j=0;_j<UserControl.SIZE;_j++){
				#region Gamepad
					_save_map_val = load("user_" + string(_i) + "_control_" + string(_j) + "_gamepad");
		
					if(_save_map_val != undefined){
						_user.control[_j].input[Input.gamepad][InputProperty.key] = _save_map_val;
						_user.control[_j].input[Input.gamepad][InputProperty.sprite] = ds_list_find_value(global.gamepad_sprite_list,_save_map_val);
					}
				#endregion
		
				#region Keyboard
					_save_map_val = load("user_" + string(_i) + "_control_" + string(_j) + "_keyboard");
		
					if(_save_map_val != undefined){
						_user.control[_j].input[Input.keyboard][InputProperty.key] = _save_map_val;
						_user.control[_j].input[Input.keyboard][InputProperty.sprite] = ds_list_find_value(global.keyboard_sprite_list,_save_map_val);
					}

				#endregion
		
				#region Mouse
					_save_map_val = load("user_" + string(_i) + "_control_" + string(_j) + "_mouse");
		
					if(_save_map_val != undefined){
						_user.control[_j].input[Input.mouse][InputProperty.key] = _save_map_val;
						_user.control[_j].input[Input.mouse][InputProperty.sprite] = ds_list_find_value(global.mouse_sprite_list,_save_map_val);
					}

				#endregion
		
				#region Mouse & Keyboard
					_save_map_val = load("user_" + string(_i) + "_control_" + string(_j) + "_mouse_and_keyboard");
		
					if(_save_map_val != undefined){
						_user.control[_j].input[Input.mouse_and_keyboard][InputProperty.key] = _save_map_val;
				
						if((_save_map_val == mb_left) || _save_map_val == mb_right || _save_map_val == mb_middle)
							_user.control[_j].input[Input.mouse_and_keyboard][InputProperty.sprite] = ds_list_find_value(global.mouse_sprite_list,_save_map_val);
						else
							_user.control[_j].input[Input.mouse_and_keyboard][InputProperty.sprite] = ds_list_find_value(global.keyboard_sprite_list,_save_map_val);
					}
				#endregion
			}
		}
	#endregion
	
	if(bad_load == true){
		//sdm(bad_load_string + "Destroying old map");
		//ds_map_destroy(save_map);
		
		//sdm(bad_load_string + "Creating new map");
		//save_map = ds_map_create();
		
		sdm(bad_load_string + "Saving Input");
		input_save();
	}
}
// Inherit the parent event
event_inherited();

#region Tab Creation
	var _x,_y,_x_center,_y_center,_x_width,_y_height;
	with(o_camera){
		_x_center = width_ini_half;
		_y_center = height_ini_half;
		_x_width = width_ini;
		_y_height = height_ini;
	}
	
	#region Pause
		//Keyboard
		_x = _x_center - 150;
		_y = _y_center - 150;
		instance_create_layer(_x,_y,"lyr_menu",o_control_map_kb_pause);
		
		//Gamepad
		_x = _x_center + 150;
		_y = _y_center - 150;
		instance_create_layer(_x,_y,"lyr_menu",o_control_map_gp_pause);
	#endregion
	
	//Jump
	_x = _x_center - 150;
	_y = _y_center + 150;
	instance_create_layer(_x,_y,"lyr_menu",o_control_map_kb_jump);
	
	//Console
	_x = _x_center + 150;
	_y = _y_center + 150;
	instance_create_layer(_x,_y,"lyr_menu",o_control_map_kb_console);
	
	#region Aim Assit
		var _aim_assist_slider;
			
		//Player 0
		_x = _x_center + 750;
		_y = _y_center + 500;
		_aim_assist_slider = instance_create_layer(_x,_y,"lyr_menu",o_sldr_gamepad_aim_assist);
		with(_aim_assist_slider){
			user = o_input.user[0];
				
			title_string = "Player 1 - Gamepad Aim Assist";
		}
			
		////Player 1
		//_x = _x_center + 1400;
		//_y = _y_center + 500;
		//_aim_assist_slider = instance_create_layer(_x,_y,"lyr_menu",o_sldr_gamepad_aim_assist);
		//with(_aim_assist_slider){
		//	user = o_input.user[1];
				
		//	title_string = "Player 2 - Gamepad Aim Assist";
		//}
	#endregion
#endregion
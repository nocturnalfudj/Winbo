//Inherit UI Object Parent
event_inherited();

#region Dimensions
	width_max = 200;
	
	width_min = 0;
	height_min = 0;

	width_buff = 10;
	height_buff = 10;
#endregion

#region Text
	text = new Text(TextGroup.ui,200);		//"PLAY"
	
	text_string = text.value;
	text_string_prev = text_string+"a";
	font = fnt_bahnschrift_32;
	alignment_h = fa_left;
	alignment_v = fa_middle;
	
	shadow_enable = true;
	shadow_x = 3;
	shadow_y = 3;
	shadow_c = c_black;
#endregion

#region Control Input
	keyboard_input_enable = false;
	gamepad_input_enable = true;
	
	input_keyboard_active = o_input.app_control[AppControl.menu_start].input[Input.keyboard][InputProperty.key];
	input_gamepad_active = o_input.app_control[AppControl.menu_start].input[Input.gamepad][InputProperty.key];
	
#endregion

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_tab_home_create_main;
	state_script[UIState.active][UIStateStage.main] = btn_start_active_main;
#endregion
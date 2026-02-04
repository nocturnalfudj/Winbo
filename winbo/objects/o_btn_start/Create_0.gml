// Inherit the parent event
event_inherited();

#region Image
	sprite_current = spr_btn_start;
#endregion

#region Control Input
	keyboard_input_enable = true;
	gamepad_input_enable = true;
	
	input_keyboard_active = o_input.app_control[AppControl.menu_start].input[Input.keyboard][InputProperty.key];
	input_gamepad_active = o_input.app_control[AppControl.menu_start].input[Input.gamepad][InputProperty.key];
		
#endregion

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_tab_home_create_main;
	state_script[UIState.active][UIStateStage.main] = btn_start_active_main;
#endregion
// Inherit the parent event
event_inherited();

//Toggle
toggle_enable = true;
button_toggle_set(false);

#region Control Input
	keyboard_input_enable = true;
	gamepad_input_enable = true;
	
	input_keyboard_active = o_input.app_control[AppControl.pause].input[Input.keyboard][InputProperty.key];
	input_gamepad_active = o_input.app_control[AppControl.pause].input[Input.gamepad][InputProperty.key];
#endregion

#region Image
	toggle_sprite_false = spr_btn_pause_off;
	toggle_sprite_true = spr_btn_pause_on;
	sprite_current = (toggle)? toggle_sprite_true : toggle_sprite_false;
#endregion

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_hud_create_main;
	state_script[UIState.idle][UIStateStage.main] = btn_pause_idle_main;
	state_script[UIState.active][UIStateStage.main] = btn_pause_active_main;
#endregion
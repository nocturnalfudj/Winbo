// Inherit the parent event
event_inherited();

//Control
control_type = ControlType.app;
control = AppControl.console;
input = Input.keyboard;
user = noone;

#region Name
	name_text = o_input.app_control[control].name;
	name_string = name_text.value;
	
	name_x = 0;
	name_y = -100;
#endregion

#region Key
	key_sprite = noone;
	
	control_map_key_update();
	
	key_x = 0;
	key_y = 0;
#endregion

//Text
text_font = fnt_bahnschrift_16;
text_colour = c_white;

#region State Scripts
	state_script[UIState.active][UIStateStage.main] = control_map_active_main;
	
	state_script[UIState.edit][UIStateStage.main] = control_map_edit_main;
#endregion
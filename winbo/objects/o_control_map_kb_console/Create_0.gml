// Inherit the parent event
event_inherited();

//Control
control_type = ControlType.app;
control = AppControl.console;
input = Input.keyboard;
user = noone;

control_map_key_update();

name_text = o_input.app_control[control].name;
name_string = name_text.value;

#region State Scripts
	state_script[UIState.edit][UIStateStage.stop] = control_map_console_edit_stop;
#endregion
// Inherit the parent event
event_inherited();

//Control
control_type = ControlType.user;
control = UserControl.jump;
input = Input.keyboard;
user = o_input.user[0];

control_map_key_update();

name_text = user.control[control].name;
name_string = name_text.value;

#region State Scripts
	state_script[UIState.edit][UIStateStage.stop] = control_map_jump_edit_stop;
#endregion
// Inherit the parent event
event_inherited();

width_max = 1500;

text_string = "[DIALOGUE NAME]";
font = fnt_default_42;
alignment_h = fa_left;
alignment_v = fa_middle;

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_dialogue_create_main;
	
	state_script[UIState.idle][UIStateStage.main] = txtPstr_dialogue_name_idle_main;
#endregion
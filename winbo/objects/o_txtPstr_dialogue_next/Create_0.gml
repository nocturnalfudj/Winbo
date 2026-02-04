// Inherit the parent event
event_inherited();

width_max = 10000;

text_string = "Click to continue...";
font = fnt_default_30;
alignment_h = fa_right;
alignment_v = fa_middle;

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_dialogue_create_main;
	
	state_script[UIState.idle][UIStateStage.main] = txtPstr_dialogue_next_idle_main;
#endregion
// Inherit the parent event
event_inherited();

text_string = "v_"+VERSION;
font = fnt_bahnschrift_16;
alignment_h = fa_center;
alignment_v = fa_middle;

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_menu_create_main;
#endregion
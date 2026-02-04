// Inherit the parent event
event_inherited();

text_string = "01:00";
font = fnt_default_42;
alignment_h = fa_center;
alignment_v = fa_middle;

advert_force_exit_percent = 1;

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_advert_create_main;
	state_script[UIState.idle][UIStateStage.main] = txtPstr_advert_idle_main;
#endregion
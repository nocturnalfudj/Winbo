// Inherit the parent event
event_inherited();

text_string = "RESULTS";
font = fnt_default_100;
alignment_h = fa_center;
alignment_v = fa_middle;

//Shadow
shadow_enable = true;
shadow_x = -4;
shadow_y = 4;
shadow_c = c_black;
shadow_alpha = 0.5;

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_results_create_main;
#endregion
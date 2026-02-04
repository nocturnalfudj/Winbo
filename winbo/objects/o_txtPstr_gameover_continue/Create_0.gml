// Inherit the parent event
event_inherited();

text_string = "CLICK TO CONTINUE";
font = fnt_default_52;
alignment_h = fa_center;
alignment_v = fa_middle;

//Shadow
shadow_enable = true;
shadow_x = -3;
shadow_y = 3;
shadow_c = c_black;
shadow_alpha = 0.5;

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_gameover_create_main;
#endregion
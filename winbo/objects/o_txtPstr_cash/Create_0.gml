// Inherit the parent event
event_inherited();

width_max = 1000;

//Prefix
prefix = noone;		//new Text(TextGroup.ui,200);		//"IDLE"
prefix_string = "";//text.value;
prefix_string_prev = prefix_string + "a";

text_string = "0";
font = fnt_default_64;
alignment_h = fa_center;
alignment_v = fa_middle;

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_hud_create_main;
	
	state_script[UIState.idle][UIStateStage.main] = txtPstr_cash_idle_main;
#endregion
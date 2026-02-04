// Inherit the parent event
event_inherited();

width_max = 1000;

//Prefix
prefix = noone;		//new Text(TextGroup.ui,200);		//"IDLE"
prefix_string = "Level Time: ";//text.value;
prefix_string_prev = prefix_string + "a";

text_string = "00:00";
font = fnt_default_30;
alignment_h = fa_left;
alignment_v = fa_middle;

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_hud_create_main;
	
	state_script[UIState.idle][UIStateStage.main] = txtPstr_level_timer_idle_main;
#endregion
//Inherit UI Object Parent
event_inherited();

#region Level Action
	level_id = "";
	action_type = "start";
#endregion

#region Dimensions
	width_max = 1000;
	
	width_min = 0;
	height_min = 0;

	width_buff = 30;
	height_buff = 15;
#endregion

#region Text
	text_string = "Level Action";
	text_string_prev = text_string + "a";
	font = fnt_default_42;
	alignment_h = fa_center;
	alignment_v = fa_middle;
	
	shadow_enable = true;
	shadow_x = -4;
	shadow_y = 4;
	shadow_c = c_black;
#endregion

#region State Scripts
	state_script[UIState.active][UIStateStage.main] = btn_level_action_active_main;
#endregion

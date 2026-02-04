//Inherit UI Object Parent
event_inherited();

#region Dimensions
	width_max = 500;
	
	width_min = 0;
	height_min = 0;

	width_buff = 30;
	height_buff = 15;
#endregion

#region Text
	text_string = "BACK";
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
	state_script[UIState.create][UIStateStage.main] = ui_tab_level_select_create_main;
	state_script[UIState.active][UIStateStage.main] = btn_back_to_home_active_main;
#endregion

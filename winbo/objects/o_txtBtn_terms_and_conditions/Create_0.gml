// Inherit the parent event
event_inherited();

#region Dimensions
	width_max = 200;
	
	width_buff = 10;
	height_buff = 10;
#endregion

#region Text
	text = new Text(TextGroup.ui,11);		//"Terms and Conditions"
	text_string = text.value;
	text_string_on = "";
	text_string_off = "";
	text_string_prev = text_string + "a";
	
	font = fnt_bahnschrift_32;
	alignment_h = fa_center;
	alignment_v = fa_middle;
#endregion

//URL
url = "";

#region State Custom Scripts
	state_script[UIState.create][UIStateStage.main] = ui_tab_credits_create_main;
	state_script[UIState.active][UIStateStage.main] = btn_social_active_main;
#endregion
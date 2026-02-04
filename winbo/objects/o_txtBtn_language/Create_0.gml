//Inherit UI Object Parent
event_inherited();

//Toggle
toggle_enable			= true;
toggle					= false;
toggle_group_enable		= true;
toggle_group			= ButtonToggleGroup.language;
toggle_group_mono		= true;		//Only one in group allowed to be toggled on
toggle_oneway_enable	= true;
toggle_oneway_direction = true;		//Can only be toggle to this value if oneway enabled

//Image
sprite_index = noone;

#region Dimensions
	width_max = 200;
	
	width_min = 0;
	height_min = 0;

	width_buff = 10;
	height_buff = 10;
#endregion

//Language
language = "";

if(o_text.language_current == language){
	button_toggle_set(true);
}

#region Text
	text_string = "Language Text Button";//text.value;
	text_string_prev = text_string + "a";
	
	font = fnt_bahnschrift_16;
	alignment_h = fa_left;
	alignment_v = fa_middle;
	
	shadow_enable = false;
	shadow_x = 0;
	shadow_y = 0;
	shadow_c = c_black;
#endregion


#region State Custom Scripts
	state_script[UIState.create][UIStateStage.main] = ui_tab_settings_language_create_main;
	state_script[UIState.active][UIStateStage.main] = btn_language_active_main;
#endregion
//Inherit UI Object Parent
event_inherited();

//Toggle
toggle_enable			= false;
toggle					= false;
toggle_group_enable		= false;
toggle_group			= noone;
toggle_group_mono		= false;		//Only one in group allowed to be toggled on
toggle_oneway_enable	= false;
toggle_oneway_direction = false;		//Can only be toggle to this value if oneway enabled
toggle_script_true		= noone;		//Script to execute when button toggle value set to true
toggle_script_false		= noone;		//Script to execute when button toggle value set to false
toggle_sprite_true		= noone;
toggle_sprite_false		= noone;

#region Dimensions
	width = 0;
	height = 0;

	width_max = 500;
	width_actual = 0;

	width_min = 0;
	height_min = 0;

	width_buff = 10;
	height_buff = 10;

	width_pre_scale = 0;
	height_pre_scale = 0;

	x1 = 0;
	y1 = 0;
	x2 = 0;
	y2 = 0;

	calculate_dimensions = true;
#endregion

#region Text
	#region Text
		text = noone;		//new Text(TextGroup.ui,200);		//"IDLE"
		text_on = noone;	//new Text(TextGroup.ui,206);		//"IDLE_toggle"
		text_off = noone;	//new Text(TextGroup.ui,200);		//"IDLE"

		text_string = "Text Button";//text.value;
		text_string_on = "";
		text_string_off = "";
		text_string_prev = text_string + "a";
	#endregion
	
	#region Prefix
		prefix = noone;		//new Text(TextGroup.ui,200);		//"IDLE"
		prefix_on = noone;	//new Text(TextGroup.ui,206);		//"IDLE_toggle"
		prefix_off = noone;	//new Text(TextGroup.ui,200);		//"IDLE"

		prefix_string = "";//text.value;
		prefix_string_on = "";
		prefix_string_off = "";
		prefix_string_prev = prefix_string + "a";
	#endregion
	
	#region Suffix
		suffix = noone;		//new Text(TextGroup.ui,200);		//"IDLE"
		suffix_on = noone;	//new Text(TextGroup.ui,206);		//"IDLE_toggle"
		suffix_off = noone;	//new Text(TextGroup.ui,200);		//"IDLE"

		suffix_string = "";//text.value;
		suffix_string_on = "";
		suffix_string_off = "";
		suffix_string_prev = suffix_string + "a";
	#endregion
	
	//Final
	text_final_string = prefix_string + text_string + suffix_string;
	text_final_string_prev = text_final_string;
	
	//Font
	font = fnt_bahnschrift_16;
	alignment_h = fa_left;
	alignment_v = fa_middle;
	
	sep = 0;
	
	//Shadow
	shadow_enable = false;
	shadow_x = 0;
	shadow_y = 0;
	shadow_c = c_black;
	shadow_alpha = 1;
	
	//Reveal
	reveal_enable = false;
	reveal_character_count = 0;
	reveal_character_count_total = 0;
	reveal_speed_default = 50 / SECOND;
	reveal_speed_fast = reveal_speed_default * 2;
	reveal_speed = reveal_speed_default;
	reveal_sound = noone;
	reveal_sound_character_count_trigger = 3;
#endregion

#region Control Input
	keyboard_input_enable = false;
	gamepad_input_enable = false;
	
	input_keyboard_active = noone;
	input_gamepad_active = noone;
#endregion

#region State Custom Scripts
	state_script[UIState.idle][UIStateStage.start] = ui_object_state_idle_start;
	
	state_script[UIState.hover][UIStateStage.start] = ui_object_state_hover_start;
	
	state_script[UIState.down][UIStateStage.start] = ui_object_state_down_start;
#endregion
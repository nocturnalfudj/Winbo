//Inherit UI Object Parent
event_inherited();

#region Dimensions
	width = 0;
	height = 0;

	width_max = 200;
	width_actual = 0;

	width_min = 0;
	height_min = 0;

	width_buff = 10;
	height_buff = 10;

	width_pre_scale = 0;
	height_pre_scale = 0;

	calculate_dimensions = true;
#endregion

#region Text
	//Text
	text = noone;//new Text(TextGroup.ui,200);		//"IDLE"
	text_string = "";//text.value;
	text_string_prev = text_string + "a";
	
	//Prefix
	prefix = noone;		//new Text(TextGroup.ui,200);		//"IDLE"
	prefix_string = "";//text.value;
	prefix_string_prev = prefix_string + "a";
	
	//Suffix
	suffix = noone;		//new Text(TextGroup.ui,200);		//"IDLE"
	suffix_string = "";//text.value;
	suffix_string_prev = suffix_string + "a";
	
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

	//Dimensions
	text_ui_set_width_height_pre_scale();
	width = width_pre_scale* image_xscale;
	height = height_pre_scale * image_yscale;
#endregion
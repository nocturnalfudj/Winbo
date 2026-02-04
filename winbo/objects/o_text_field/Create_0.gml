//Inherit UI Object Parent
event_inherited();

#region Image
	sprite_current = spr_console_text_field;
	
	sprite_frame = noone;
	frame_enable = false;
#endregion

#region Text
	text_string = "";
	text_string_prev = text_string+"a";
	
	//Transform
	text_x = 24;
	text_y = 0;
	text_alignment_h = fa_left;
	text_alignment_v = fa_middle;
	text_width = sprite_get_width(sprite_current)*0.9;
	
	//Font & Colour
	text_font = fnt_bahnschrift_16;
	text_colour = c_black;

	#region Edit
		text_edit_enable = true;
		text_edit_empty = true;
		keyboard_string_length_prev = 0;
	
		#region Edit Position
			#macro TEXT_FIELD_EDIT_POS_STRING "|"
			#macro TEXT_FIELD_EDIT_POS_BLINK_COUNTDOWN 30
		
			text_edit_pos_current = 0;
		
			text_edit_pos_blink = false;
			text_edit_pos_blink_countdown = 0;
			text_edit_pos_blink_x = 0;
			text_edit_pos_blink_y = 0;
		#endregion
		
		#region Highlight
			text_highlight_enable = true;
			text_highlight_active = false;
			text_highlight_string = "";
			text_highlight_start = 0;
			text_highlight_middle = 0;
			text_highlight_end = 0;
			text_highlight_c = c_aqua;
			text_highlight_h_half = string_height_ext("|",0,10000)*1.25*0.5;
	
			text_highlight_x1 = 0;
			text_highlight_x2 = 0;
		
			#macro TEXT_FIELD_HIGHLIGHT_ALPHA 0.5
		#endregion
	#endregion

	#region Mobile Virtual Keyboard
		mobile_virtual_keyboard_display = "hidden";
		mobile_virtual_keyboard_show = false;
	#endregion
	
	#region Hint
		hint_text_enable = false;
		hint_text = noone;
		hint_string = "Enter text here!"; //hint_text.value;
		hint_colour = c_ags_red;
	#endregion
	
	password_enable = false;
	password_string = "";
#endregion

#region Title
	//Create Title System
	title_system_create();

	//Title
	title_string = "Text Field Title";
	title_halign = fa_left;
	title_valign = fa_middle;
	title_font = fnt_bahnschrift_16;
	title_colour = c_white;
	
	//Subtitle
	subtitle_halign = fa_left;
	subtitle_valign = fa_middle;
	subtitle_font = fnt_bahnschrift_16;
	subtitle_colour = c_white;
#endregion
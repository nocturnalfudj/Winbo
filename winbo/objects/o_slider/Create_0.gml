//Inherit UI Object Parent
event_inherited();

#region Slider
	live = false;
	
	vertical = false;
	
	frame_enable = true;
	pointer_enable = true;

	group_enable = false;
	group = noone;

	#region Value
		value_current = 0;
		value_previous = value_current;
		value_current_clamp_enable = true;

		value_max = 10;
		value_max_previous = value_max;

		value_min = 0;
		value_min_previous = value_min;
		
		value_current_percent = (value_current-value_min) / (value_max-value_min);
		
		percent = false;
		percent_of_max = true;
		decimal_digits = 0;
	#endregion

	#region Discrete
		discrete = false;
		discrete_count = 4;
		discrete_bar_enable = false;
	#endregion

	#region Slider Draw
		draw_all = false;
		draw_part = true;
		draw_part_len = 0;
		draw_part_len_beyond_max = 0;
		
		draw_slider_x = 0;
		draw_slider_y = 0;
	#endregion
#endregion

#region Image
	sprite_current = spr_slider_horizontal;
	sprite_frame = noone;
	sprite_background = spr_slider_horizontal_background;
	sprite_pointer = spr_slider_horizontal_pointer;
	sprite_discrete_bar = spr_slider_horizontal_discrete_bar;
#endregion

#region Dimensions
	dimensions_system_update(sprite_background);

	slider_sprite_width = sprite_get_width(sprite_current);
	slider_sprite_height = sprite_get_height(sprite_current);
	
	slider_sprite_width_half = slider_sprite_width/2;
	slider_sprite_height_half = slider_sprite_height/2;
#endregion

//Pointer
pointer_position = new TransValue(1);
pointer_beyond_max_position = noone;

#region Text
	var _text_y_gap = height*2.5;

	#region Values
		#region Current
			text_value_current = string(value_current);
			text_value_current_enable = false;
			text_value_current_font = fnt_bahnschrift_16;
			text_value_current_colour = c_white;
			text_value_current_halign = fa_center;
			text_value_current_valign = fa_middle;
			text_value_current_x = 0;
			text_value_current_y = -_text_y_gap;
		#endregion

		#region Min
			text_value_min = string(value_min);
			text_value_min_enable = false;
			text_value_min_font = fnt_bahnschrift_16;
			text_value_min_colour = c_white;
			text_value_min_halign = fa_center;
			text_value_min_valign = fa_middle;
			text_value_min_x = -(width_half + 50);
			text_value_min_y = 0;
		#endregion

		#region Max
			text_value_max = string(value_max);
			text_value_max_enable = false;
			text_value_max_font = fnt_bahnschrift_16;
			text_value_max_colour = c_white;
			text_value_max_halign = fa_center;
			text_value_max_valign = fa_middle;
			text_value_max_x = width_half + 50;
			text_value_max_y = 0;
		#endregion
	#endregion
	
	//Create Title System
	title_system_create();
	
	#region Subtitle Y
		//Raise Above Discrete Bars if Enabled
		subtitle_y = -_text_y_gap;
		
		//Raise Above Value Current if Enabled
		if(text_value_current_enable)
			subtitle_y += text_value_current_y;
	#endregion

	#region Title Y
		//Raise Above Discrete Bars if Enabled
		title_y = -_text_y_gap;
		
		//Raise Above Value Current if Enabled
		if(text_value_current_enable)
			title_y += text_value_current_y +_text_y_gap/2;
			
		//Raise Above Subtitle Current if Enabled
		if(subtitle_enable)
			title_y += subtitle_y +_text_y_gap/2;
	#endregion
#endregion

#region State Custom Scripts
	state_script[UIState.idle][UIStateStage.start] = ui_object_state_idle_start;
	
	state_script[UIState.hover][UIStateStage.start] = ui_object_state_hover_start;
	
	state_script[UIState.down][UIStateStage.start] = ui_object_state_down_start;
#endregion
//Inherit UI Object Parent
event_inherited();

#region Slider
	live = true;
	
	vertical = false;
	
	frame_enable = true;
	pointer_enable = true;

	#region Value
		value_current = 0;
		value_previous = value_current;

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
		draw_all = true;
		draw_part = false;
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

//Scroll
scroll = noone;

#region State Custom Scripts
	state_script[UIState.idle][UIStateStage.main] = scroll_slider_idle_main;
	state_script[UIState.down][UIStateStage.start] = scroll_slider_down_start;
	state_script[UIState.active][UIStateStage.main] = scroll_slider_active_main;
#endregion
//Inherit UI Object Parent
event_inherited();

#region Image
	sprite_current = sprite_index;
#endregion

#region Control Input
	keyboard_input_enable = false;
	gamepad_input_enable = false;
	
	input_keyboard_active = noone;
	input_gamepad_active = noone;
#endregion

#region Title System
	title_enable = false;
	title_text = noone;
	title_string = "HOLD";
	title_font = fnt_default_20;
	title_colour = c_white;
	title_halign = fa_center;
	title_valign = fa_middle;
	title_x = 0;
	title_y = -50;
	title_shadow_enable = true;
	title_shadow_colour = c_black;
	title_shadow_x = -3;
	title_shadow_y = 3;
	
	subtitle_enable = true;
	subtitle_text = noone;
	subtitle_string = "";
	subtitle_font = fnt_default_24;
	subtitle_colour = c_white;
	subtitle_halign = fa_center;
	subtitle_valign = fa_middle;
	subtitle_x = 0;
	subtitle_y = -100;
	subtitle_width = 1000;
	subtitle_shadow_enable = true;
	subtitle_shadow_colour = c_black;
	subtitle_shadow_x = -4;
	subtitle_shadow_y = 4;
	subtitle_shadow_alpha = 0.75;
#endregion

//Key
key_sprite = noone;
key_draw_enable = true;

//Interaction
interaction = noone;

//Position Relative Instance
position_relative_instance = noone;
position_relative_x = 0;
position_relative_y = 0;

//Down Time Indicator
down_time_indicator_enable = false;
down_time_indicator_percent = 0;
down_time_indicator_x = 0;
down_time_indicator_y = 0;

#region State Scripts
	var _state;
	_state = UIState.create;
	state_script[_state][UIStateStage.start] = noone;
	state_script[_state][UIStateStage.main] = noone;
	state_script[_state][UIStateStage.stop] = noone;
	
	_state = UIState.idle;
	state_script[_state][UIStateStage.start] = noone;
	state_script[_state][UIStateStage.main] = interact_indicator_idle_main;
	
	_state = UIState.hover;
	state_script[_state][UIStateStage.main] = interact_indicator_idle_main;
	
	_state = UIState.down;
	state_script[_state][UIStateStage.main] = interact_indicator_btn_down_main;
	
	_state = UIState.active;
	state_script[_state][UIStateStage.main] = interact_indicator_idle_main;
#endregion
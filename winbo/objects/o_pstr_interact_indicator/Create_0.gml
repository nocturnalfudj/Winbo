// Inherit the parent event
event_inherited();

//Key
key_sprite = noone;
key_draw_enable = true;

#region Title System
	title_system_create();
	
	title_enable = true;
	title_text = noone;
	title_string = "";
	title_font = fnt_default_24;
	title_colour = c_white;
	title_halign = fa_center;
	title_valign = fa_middle;
	title_x = 0;
	title_y = -100;
	title_width = 1000;
	title_shadow_enable = true;
	title_shadow_colour = c_black;
	title_shadow_x = -4;
	title_shadow_y = 4;
	title_shadow_alpha = 0.75;
	
	subtitle_enable = false;
	subtitle_text = noone;
	subtitle_string = "HOLD";
	subtitle_font = fnt_default_20;
	subtitle_colour = c_white;
	subtitle_halign = fa_center;
	subtitle_valign = fa_middle;
	subtitle_x = 0;
	subtitle_y = -50;
	subtitle_shadow_enable = true;
	subtitle_shadow_colour = c_black;
	subtitle_shadow_x = -3;
	subtitle_shadow_y = 3;
#endregion

//GUI
gui = false;

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
	state_script[_state][UIStateStage.stop] = noone;
#endregion
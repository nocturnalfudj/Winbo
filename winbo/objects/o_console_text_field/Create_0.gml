// Inherit the parent event
event_inherited();

#region GameState Operate
	game_state_operate[GameState.boot]				= UIGameStateOperate.full_step;
	game_state_operate[GameState.intro]				= UIGameStateOperate.full_step;
	game_state_operate[GameState.loading_app]		= UIGameStateOperate.full_step;
	game_state_operate[GameState.os_paused]			= UIGameStateOperate.full_step;
	game_state_operate[GameState.menu]				= UIGameStateOperate.full_step;
	game_state_operate[GameState.start]				= UIGameStateOperate.full_step;
	game_state_operate[GameState.play]				= UIGameStateOperate.full_step;
	game_state_operate[GameState.loading]			= UIGameStateOperate.full_step;
	game_state_operate[GameState.game_menu]			= UIGameStateOperate.full_step;
	game_state_operate[GameState.pause]				= UIGameStateOperate.full_step;
	game_state_operate[GameState.freeze]			= UIGameStateOperate.full_step;
	game_state_operate[GameState.gameover]			= UIGameStateOperate.full_step;
	game_state_operate[GameState.stop]				= UIGameStateOperate.full_step;
	game_state_operate[GameState.cutscene]			= UIGameStateOperate.full_step;
	game_state_operate[GameState.close]				= UIGameStateOperate.nothing;
#endregion

#region Image
	sprite_current = spr_console_text_field;
	sprite_frame = spr_console_text_field;
#endregion

#region Text
	//Transform
	text_x = 24;
	text_y = 0;
	text_alignment_h = fa_left;
	text_alignment_v = fa_middle;
	text_width = 10000;//sprite_get_width(sprite_current)*0.9;
	
	//Font & Colour
	text_font = fnt_bahnschrift_16;
	text_colour = c_black;

	#region Edit
		text_edit_enable = true;
		text_edit_empty = false;
	#endregion

	#region Hint
		hint_text_enable = true;
		hint_text = noone;
		hint_string = "Enter command"; //hint_text.value;
		hint_colour = c_ags_red;
	#endregion
#endregion

#region Console
	command_list = ds_list_create();
	command_list_pos = 0;
	
	command_stage = 0;
	command_subject = 0;
	command_action = -1;
	command_argument = -1;
	command_argument_slot = -1;
#endregion

#region State Scripts
	state_script[UIState.idle][UIStateStage.main] = console_text_field_idle_main;

	state_script[UIState.edit][UIStateStage.start] = console_text_field_edit_start;
	state_script[UIState.edit][UIStateStage.stop] = console_text_field_edit_stop;
	state_script[UIState.edit][UIStateStage.main] = console_text_field_edit_main;

	state_script[UIState.active][UIStateStage.main] = console_text_field_active_main;
#endregion
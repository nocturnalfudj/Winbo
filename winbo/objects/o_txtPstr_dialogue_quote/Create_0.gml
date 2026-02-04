// Inherit the parent event
event_inherited();

width_max = 2500;

text_string = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
font = fnt_default_38;
alignment_h = fa_left;
alignment_v = fa_top;

//Reveal
reveal_enable = true;
reveal_speed_default = 35 / SECOND;
reveal_speed_fast = reveal_speed_default * 2;
reveal_speed = reveal_speed_default;
reveal_sound = noone;
reveal_sound_character_count_trigger = 3;

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_dialogue_create_main;
	
	state_script[UIState.idle][UIStateStage.main] = txtPstr_dialogue_quote_idle_main;
#endregion
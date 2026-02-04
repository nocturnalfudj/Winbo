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

#region Image
	sprite_current = sprite_index;
#endregion

//Create Title System
title_system_create();

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
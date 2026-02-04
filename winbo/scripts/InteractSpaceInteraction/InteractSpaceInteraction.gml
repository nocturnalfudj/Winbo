function InteractSpaceInteraction(_space) constructor{
	//Space that the Interaction Belongs to
	_space ??= other;
	space = _space;
	
	//Enable
	enable = true;
	enable_input = true;
	
	//Control
	control = UserControl.interact;
	control_pressed_required = true;
		
	//Title
	title_string = "INTERACTION TITLE";
	title_colour = c_white;
	subtitle_string = "INTERACTION SUBTITLE";
	subtitle_colour = c_white;
		
	//Icon
	icon = noone;
		
	//Indicator
	indicator_instance = noone;
	indicator_part_of_group = true;
	indicator_position_relative_to_interactor = false;	//Only considered if indicator_part_of_group is false
	indicator_x = 0;
	indicator_y = 0;
	indicator_object = o_pstr_interact_indicator;
	indicator_object_contributing_to_down_time = false;
		
	#region State Scripts
		//These scripts are executed in the scope of the object instance, NOT the Interact Space Interaction
		//User ID and the Interact Space Interaction data are passed in as the first two parameters
		state_script[InteractSpaceState.idle] = noone;
		state_script[InteractSpaceState.hover] = noone;
		state_script[InteractSpaceState.down] = noone;
		state_script[InteractSpaceState.active] = noone;
	#endregion
	
	//On Active Indicator Rules
	on_active_remove_indicator = false;
	on_active_remove_space_indicator_anchor = false;
		
	//Down Time
	down_time_required = 0;
	down_time_current = 0;
	down_time_reduce_speed = INTERACT_DOWN_TIME_REDUCE_SPEED_INSTANT;
	down_time_attack_contribution = 0;
	
	#region Indicator
		indicator_enable = true;
		
		//Key
		indicator_control_key_draw_enable = true;
	
		//Down Time
		indicator_down_time_enable = true;
		indicator_down_time_x = 0;
		indicator_down_time_y = 100;
	#endregion
		
	#region Toggle
		toggle_enable			= false;
		toggle					= false;
		toggle_group_enable		= false;
		toggle_group			= noone;
		toggle_group_mono		= false;	//Only one in group allowed to be toggled on
		toggle_oneway_enable	= false;
		toggle_oneway_direction	= false;	//Can only be toggle to this value if oneway enabled
		toggle_script_true		= noone;	//Script to execute when interact toggle value set to true
		toggle_script_false		= noone;	//Script to execute when interact toggle value set to false
		
		//Example
		//interact_system_toggle_group_space_interaction_add(InteractToggleGroup.run_mode);
	#endregion
}
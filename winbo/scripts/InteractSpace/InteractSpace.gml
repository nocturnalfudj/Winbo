function InteractSpace(_interaction_count) constructor{
	//Name
	name = "INTERACT SPACE";
	
	#region State
		state = InteractSpaceState.idle;
		
		#region State Scripts
			var _state;
			_state = InteractSpaceState.idle;
			state_script[_state][InteractSpaceStateStage.start] = noone;
			state_script[_state][InteractSpaceStateStage.main] = noone;
			state_script[_state][InteractSpaceStateStage.stop] = noone;
	
			_state = InteractSpaceState.hover;
			state_script[_state][InteractSpaceStateStage.start] = noone;
			state_script[_state][InteractSpaceStateStage.main] = noone;
			state_script[_state][InteractSpaceStateStage.stop] = noone;
	
			_state = InteractSpaceState.down;
			state_script[_state][InteractSpaceStateStage.start] = noone;
			state_script[_state][InteractSpaceStateStage.main] = noone;
			state_script[_state][InteractSpaceStateStage.stop] = noone;
	
			_state = InteractSpaceState.active;
			state_script[_state][InteractSpaceStateStage.start] = noone;
			state_script[_state][InteractSpaceStateStage.main] = noone;
			state_script[_state][InteractSpaceStateStage.stop] = noone;
		#endregion
	#endregion
	
	#region Users
		//Position
		user_position = InteractUserPosition.range;
		user_position_x = 0;
		user_position_y = 0;
		user_position_x2 = 0;
		user_position_y2 = 0;
		user_position_range = 500;
		
		//Users
		for(var _i=0;_i<USER_NUM_MAX;_i++){
			user_in_position[_i] = false;
			user_x[_i] = 0;
			user_y[_i] = 0;
			user_active[_i] = false;
			user_active_interaction[_i] = noone;
			user_indicator_anchor[_i] = noone;
		}
	#endregion
	
	#region Indicators
		//Anchor
		indicator_anchor_x = 0;
		indicator_anchor_y = 0;
		indicator_anchor_position_relative_to_interactor = true;
		indicator_anchor_group_distribution_script = anchor_interact_group_distribution_list_horizontal;
		
		//TODO - Implement properly (right now only non-ui works properly)
		indicator_gui = false;	//Whether the indicators use the GUI or not
	#endregion
	
	//Interactions
	for(var _i=0;_i<USER_NUM_MAX;_i++){
		for(var _j=0;_j<_interaction_count;_j++){
			interaction[_i][_j] = noone;
		}
	}
	interaction_count = _interaction_count;
	//interact_system_create_space_interaction(self);
}
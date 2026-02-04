function interact_space_state_active(_interact_instance,_space,_interact_enable,_interact_attack_enable){
	var _state_stop,_state_current,_state_target;
	_state_stop = false;
	_state_current = state;
	_state_target = noone;
	
	var _interaction,_interaction_active,_interaction_active_id;
	_interaction_active = noone;
	
	var _player_in_position;
	_player_in_position = false;
	
	var _control,_control_pressed_required;
	
	var _interaction_state_script,_interaction_on_active_remove_indicator,_interaction_on_active_remove_space_indicator_anchor,_interaction_state_script_user_id;
	_interaction_state_script = noone;
	_interaction_on_active_remove_indicator = false;
	_interaction_on_active_remove_space_indicator_anchor = false;
	_interaction_state_script_user_id = noone;
	
	//Interactions Exist
	if(interaction_count > 0){
		#region Consider Attack Trigger First
			//if(_interact_attack_enable){
			//	//Check if Attack Triggered
			//	if(other.interact_attack_trigger == true){
			//		//Specific Team Required
			//		if((other.interact_attack_team == noone) || (other.interact_attack_team == other.hit_attacker_last_team)){
			//			var _hit_attacker_last;
			//			_hit_attacker_last = other.hit_attacker_last;
						
			//			with(_hit_attacker_last){
			//				if(is_player){
			//					_interaction_state_script_user_id = user_id;
			//				}
			//			}
						
			//			//Get Attack Interaction
			//			_interaction = interaction[_interaction_state_script_user_id][other.interact_attack_space_interaction];
						
			//			//Flag as Active Interaction for User
			//			user_active_interaction[_interaction_state_script_user_id] = other.interact_attack_space_interaction;
						
			//			//Interaction Setup
			//			if(_interaction == noone){
			//				interact_space_interaction_setup(_space,_interaction_state_script_user_id);
			//			}
						
			//			//Get Attack Interaction
			//			_interaction = interaction[_interaction_state_script_user_id][other.interact_attack_space_interaction];
						
			//			//Go into Specific Interation for Attack
			//			with(_interaction){
			//				//Ignore if Disabled
			//				if(!enable || !enable_input){
			//					//Reset Active Script User to Noone
			//					_interaction_state_script_user_id = noone;
			//					break;
			//				}
							
			//				//Set Active Script to Execute
			//				_interaction_active = _interaction;
			//				_interaction_state_script = state_script[InteractSpaceState.active];
			//				_interaction_on_active_remove_indicator = on_active_remove_indicator;
			//				_interaction_on_active_remove_space_indicator_anchor = on_active_remove_space_indicator_anchor;
			//			}
			//		}
			//	}
			//}
		#endregion
		
		//Check if Players are in Position
		interact_system_user_in_position_update(_space);
		
		//Go Through Each User
		for(var _i=0;_i<USER_NUM_MAX;_i++){
			if(user_in_position[_i]){
				//Player in Position
				_player_in_position = true;
			}
			
			//if(user_in_position[_i] && user_active[_i]){
			if(user_active[_i]){
				//Reset User Active
				user_active[_i] = false;
				
				//Get Active Interaction ID
				_interaction_active_id = user_active_interaction[_i];
				
				//Go Through All Interactions
				for(var _j=0;_j<interaction_count;_j++){
					_interaction = interaction[_i][_j];
					with(_interaction){
						//Active Interaction ID Match
						//AND
						//Enabled
						if((_j == _interaction_active_id) && (enable)){
							_interaction_active = _interaction;
							
							//Toggle
							if(toggle_enable){
								if((!toggle_oneway_enable) || ((toggle_oneway_enable) && (toggle != toggle_oneway_direction))){
									//Update Toggle State
									interact_system_space_interaction_toggle_set(!toggle);
		
									//Set Active Script to Execute
									_interaction_state_script = state_script[InteractSpaceState.active];
									_interaction_on_active_remove_indicator = on_active_remove_indicator;
									_interaction_on_active_remove_space_indicator_anchor = on_active_remove_space_indicator_anchor;
									_interaction_state_script_user_id = _i;
			
									//If Interaction Instance is in an Interact Toggle Group that can have only One Interaction Instance Toggled
									if(toggle_group_enable && toggle_group_mono){
										var _toggle_group
										_toggle_group = toggle_group;
				
										with(o_director){
											//Get Number of Space Interactions in Group
											var _list_size;
											_list_size = ds_list_size(interact_toggle_group_space_interaction_list[_toggle_group]);
					
											//Go Through All Space Interactions in the Toggle Group List
											for(var _i=0;_i<_list_size;_i++){
												//If Space Interaction is Another Space Interaction in Toggle Group
												if((id!=other.id) && (toggle_enable) && (toggle_group_enable) && (toggle_group == other.toggle_group)){
													//Update Toggle State to False
													interact_system_space_interaction_toggle_set(false);
				
													//Space State to Idle
													with(space){
														interact_space_state_set(InteractSpaceState.idle);
													}
												}
											}
										}
									}
								}
							}
							else{
								//Set Active Script to Execute
								_interaction_state_script = state_script[InteractSpaceState.active];
								_interaction_on_active_remove_indicator = on_active_remove_indicator;
								_interaction_on_active_remove_space_indicator_anchor = on_active_remove_space_indicator_anchor;
								_interaction_state_script_user_id = _i;
							}
						}
						
						//Reset Down Time Current
						if(down_time_current > 0){
							down_time_current = 0;
						}
					}
				}
			}
			else{
				#region Remove User's Indicator Group Anchor
					if(user_indicator_anchor[_i] != noone){
						with(user_indicator_anchor[_i]){
							//Disappear
							transform_animate_from_current_shrink_and_fade(0.2*SECOND);
								
							//State to Destroy
							ui_object_state_set(UIState.destroy);
						}
							
						user_indicator_anchor[_i] = noone;
					}
				#endregion
			}
		}
	}
	
	#region On Active Indicator Rules
		//User ID Was Assigned
		if(_interaction_state_script_user_id != noone){
			//Remove User's Interaction Indicator
			if(_interaction_on_active_remove_indicator){
				with(_interaction_active){
					with(indicator_instance){
						//Disappear
						transform_animate_from_current_shrink_and_fade(0.2*SECOND);
								
						//State to Destroy
						ui_object_state_set(UIState.destroy);
					}
							
					indicator_instance = noone;
					
					//Disable Input
					enable_input = false;
				}
			}
			
			//Remove User's Indicator Group Anchor
			if(_interaction_on_active_remove_space_indicator_anchor){
				if(user_indicator_anchor[_interaction_state_script_user_id] != noone){
					with(user_indicator_anchor[_interaction_state_script_user_id]){
						//Disappear
						transform_animate_from_current_shrink_and_fade(0.2*SECOND);
								
						//State to Destroy
						ui_object_state_set(UIState.destroy);
					}
							
					user_indicator_anchor[_interaction_state_script_user_id] = noone;
				}
			}
		}
	#endregion
	
	//A Player is in Position
	if(_player_in_position){
		//State to Hover
		interact_space_state_set(InteractSpaceState.hover);
	}
	else{
		//State to Idle
		interact_space_state_set(InteractSpaceState.idle);
	}
	
	//Reset Attack Trigger
	_interact_instance.interact_attack_trigger = false;

	//Main Script
	interact_space_state_script_stage_execute(InteractSpaceState.active,InteractSpaceStateStage.main);
	
	//Interaction State Script
	with(_interact_instance){
		if(_interaction_state_script != noone){
			script_execute(_interaction_state_script,_interaction_state_script_user_id,_interaction_active);
		}
	}
	
	//Stop Script
	interact_space_state_script_stage_execute(InteractSpaceState.active,InteractSpaceStateStage.stop);
}
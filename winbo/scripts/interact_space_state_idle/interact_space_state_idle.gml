function interact_space_state_idle(_interact_instance,_space,_interact_enable,_interact_attack_enable){	
	var _state_stop,_state_current,_state_target;
	_state_stop = false;
	_state_current = state;
	_state_target = noone;
	
	var _interaction;
	
	var _all_interactions_down_time_0;
	
	var _interaction_state_script,_interaction_state_script_user_id;
	_interaction_state_script = noone;
	_interaction_state_script_user_id = noone;
	
	//Interactions Exist
	if((_interact_enable) && (interaction_count > 0)){
		//Check if Players are in Position
		interact_system_user_in_position_update(_space);
	}
	
	//Go Through Each User
	for(var _i=0;_i<USER_NUM_MAX;_i++){
		//Assume All Interactions Are Not Being Interacted With
		_all_interactions_down_time_0 = true;
		
		//No Interaction is Active
		user_active_interaction[_i] = noone;
		
		//Go Through All Interactions
		for(var _j=0;_j<interaction_count;_j++){
			_interaction = interaction[_i][_j];
			with(_interaction){
				//Reduce Down Time Current
				if((down_time_current > 0) && (down_time_reduce_speed != 0)){
					if(down_time_reduce_speed == INTERACT_DOWN_TIME_REDUCE_SPEED_INSTANT){
						down_time_current = 0;
					}
					else{
						down_time_current -= down_time_reduce_speed * global.delta_time_factor;
					}
			
					if(down_time_current < 0){
						down_time_current = 0;
					}
					else{
						//At Least One Interaction Has Some Down Time Left
						_all_interactions_down_time_0 = false;
					}
				}
				
				//Interaction State Script
				if(state_script[InteractSpaceState.idle] != noone){
					_interaction_state_script = state_script[InteractSpaceState.idle];
					_interaction_state_script_user_id = _i;
							
					with(_interact_instance){
						if(_interaction_state_script != noone){
							script_execute(_interaction_state_script,_interaction_state_script_user_id,_interaction);
						}
					}
				}
			}
		}
		
		if(user_in_position[_i]){
			//State to Hover
			_state_target = InteractSpaceState.hover;
		
			//Finished with State
			_state_stop = true;
				
			//Interaction Setup
			if(interaction[_i][0] == noone){
				interact_space_interaction_setup(_space,_i);
			}
			
			//Break out of Loop
			break;
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
			
			//All Interactions Are Not Being Interacted With
			if(_all_interactions_down_time_0){
				//Go Through All Interactions
				for(var _j=0;_j<interaction_count;_j++){
					//Ignore if Already Deleted
					if(interaction[_i][_j] == noone)
						break;
				
					//Delete Data
					delete interaction[_i][_j];
					interaction[_i][_j] = noone;
				}
			}
		}
	}
	
	//Attack Trigger
	if((_interact_enable) && (_interact_attack_enable)){
		//Check if Attack Triggered
		if(other.interact_attack_trigger == true){
			//Specific Team Required
			if((other.interact_attack_team == noone) || (other.interact_attack_team == other.hit_attacker_last_team)){
				var _hit_attacker_last,_attack_user_id;
				_attack_user_id = noone;
				_hit_attacker_last = other.hit_attacker_last;
				with(_hit_attacker_last){
					if(is_player){
						_attack_user_id = user_id;
					}
				}
				
				//Still Noone At This Point
				//Assume a non player (but still player team) entity has triggered the attack interaction
				if(_attack_user_id == noone){
					//So ignore it
					other.hit_attacker_last_team = noone;
					other.interact_attack_trigger = false;
				}
				else{
					//Get Attack Interaction
					_interaction = interaction[_attack_user_id][other.interact_attack_space_interaction];
				
					//Flag as Active Interaction for User
					user_active_interaction[_attack_user_id] = other.interact_attack_space_interaction;
					user_active[_attack_user_id] = true;
				
					//Interaction Setup
					if(_interaction == noone){
						interact_space_interaction_setup(_space,_attack_user_id);
					
						//Get Attack Interaction
						_interaction = interaction[_attack_user_id][other.interact_attack_space_interaction];
					}
						
					//Go into Specific Interation for Attack
					with(_interaction){
						//Ignore if Disabled
						if(!enable || !enable_input){
							break;
						}
					
						//If Down Time Required
						if((down_time_required > 0) && (down_time_current < down_time_required)){
							//Attack Down Time Contribution
							down_time_current += down_time_attack_contribution;
				
							//Down Time Required Reached
							if(down_time_current >= down_time_required){
								//State to Active
								_state_target = InteractSpaceState.active;
							}
							//Otherwise Go to Down State
							else{
								//State to Down
								_state_target = InteractSpaceState.down;
							}
						}
						//Otherwise Go Straight to Active
						else{
							//State to Active
							_state_target = InteractSpaceState.active;
						}
					
						//Finished with State
						_state_stop = true;
					}
				}
			}
		}
	}
	
	//Set State
	if(_state_stop && (_state_target != noone))
		interact_space_state_set(_state_target);

	//Custom Script
	var _stage;
	_stage = (_state_stop)? InteractSpaceStateStage.stop : InteractSpaceStateStage.main;
	interact_space_state_script_stage_execute(_state_current,_stage);
}
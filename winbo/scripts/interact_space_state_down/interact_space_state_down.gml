function interact_space_state_down(_interact_instance,_space,_interact_enable,_interact_attack_enable){
	var _state_stop,_state_current,_state_target;
	_state_stop = false;
	_state_current = state;
	_state_target = noone;
	
	var _interaction;
	
	var _player_in_position;
	_player_in_position = false;
	
	var _any_user_control_pushed;
	_any_user_control_pushed = false;
	
	var _control;
	
	var _user_input,_user_input_device,_user_gamepad_using;
	var _user_input_control_key,_user_input_control_sprite;
	var _user_control_pushed;
	var _user_input_control_key_gamepad,_user_input_control_sprite_gamepad;
	
	var _interaction_state_script,_interaction_state_script_user_id;
	_interaction_state_script = noone;
	_interaction_state_script_user_id = noone;
	
	//Interactions Exist
	if(interaction_count > 0){
		#region Consider Attack Trigger First
			if(_interact_attack_enable){
				//Check if Attack Triggered
				if(other.interact_attack_trigger == true){
					//Specific Team Required
					if((other.interact_attack_team == noone) || (other.interact_attack_team == other.hit_attacker_last_team)){
						var _hit_attacker_last,_attack_user_id;
						_hit_attacker_last = other.hit_attacker_last;
						_attack_user_id = noone;
						
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
							
								//Simulate Button Being Pushed
								_any_user_control_pushed = true;
							
								//If Down Time Required
								if(down_time_required > 0){
									//Attack Down Time Contribution
									down_time_current += down_time_attack_contribution;
								
									var _user_id;
									_user_id = noone;
									with(_hit_attacker_last){
										if(is_player){
											_user_id = user_id;
										}
									}
								
									//Interaction State Script
									if(state_script[InteractSpaceState.down] != noone){
										_interaction_state_script = state_script[InteractSpaceState.down];
										_interaction_state_script_user_id = _user_id;
							
										with(_interact_instance){
											if(_interaction_state_script != noone){
												script_execute(_interaction_state_script,_interaction_state_script_user_id,_interaction);
											}
										}
									}
								
									//If No More Down Time Required
									if(down_time_current >= down_time_required){
										//State to Active
										_state_target = InteractSpaceState.active;
									}
		
									//Finished with State
									_state_stop = true;
								}
								//Otherwise Go Straight to Active
								else{
									//State to Active
									_state_target = InteractSpaceState.active;
								
									//Finished with State
									_state_stop = true;
								}
							}
						}
					}
				}
			}
		#endregion
		
		//Check if Players are in Position
		interact_system_user_in_position_update(_space);
		
		//Go Through Each User
		for(var _i=0;_i<USER_NUM_MAX;_i++){
			if(user_in_position[_i] && user_active[_i]){
				//Skip if Already Going to Active State
				if(_state_target == InteractSpaceState.active)
					continue;
				
				//Player in Position
				_player_in_position = true;
				
				#region Indicator UI
					//Anchor Doesn't Exist
					if(user_indicator_anchor[_i] == noone){
						var _indicator_anchor_relative_x,_indicator_anchor_relative_y,_indicator_anchor_position_relative_to_interactor,_indicator_anchor_group_distribution_script,_indicator_gui;
						_indicator_anchor_relative_x = indicator_anchor_x;
						_indicator_anchor_relative_y = indicator_anchor_y;
						_indicator_anchor_position_relative_to_interactor = indicator_anchor_position_relative_to_interactor;
						_indicator_anchor_group_distribution_script = indicator_anchor_group_distribution_script;
						_indicator_gui = indicator_gui;
						
						var _indicator_anchor_position_relative_instance,_interact_system_instance,_interactor_instance;
						_interact_system_instance = other.id;
						_interactor_instance = o_input.user[_i].player_instance;
						_indicator_anchor_position_relative_instance = (_indicator_anchor_position_relative_to_interactor) ? _interactor_instance : _interact_system_instance;
						
						var _indicator_anchor_x,_indicator_anchor_y;
						_indicator_anchor_x = _indicator_anchor_relative_x;
						_indicator_anchor_y = _indicator_anchor_relative_y;
						with(_indicator_anchor_position_relative_instance){
							_indicator_anchor_x += x;
							_indicator_anchor_y += y;
						}
						
						user_indicator_group_anchor = instance_create_layer(_indicator_anchor_x,_indicator_anchor_y,"lyr_hud",o_anchor_interact);
						with(user_indicator_group_anchor){
							interact_space = _space;
							
							//Interact User
							interact_user_id = _i;
							
							position_relative_x = _indicator_anchor_relative_x;
							position_relative_y = _indicator_anchor_relative_y;
							distribution_script = _indicator_anchor_group_distribution_script;
							gui = _indicator_gui;
							
							//Instance References
							position_relative_instance = _indicator_anchor_position_relative_instance;
							interact_system_instance = _interact_system_instance;
							interactor_instance = _interactor_instance;
						}
					}
				#endregion
				
				//Go Through All Interactions
				for(var _j=0;_j<interaction_count;_j++){
					//Skip if Already Going to Active State
					if(_state_target == InteractSpaceState.active)
						break;
					
					_interaction = interaction[_i][_j];
					with(_interaction){
						//No Interaction Control Push Yet
						//AND
						//Enabled
						if((!_any_user_control_pushed) && (enable)){
							_control = control;
							
							//Get User's Input
							_user_control_pushed = noone;
							_user_input_control_sprite = noone;
							if((_control != noone) && (enable_input)){
								with(o_input.user[_i]){
									_user_input = input;
									_user_input_device = input_device;
									_user_gamepad_using = gamepad_using;
						
									with(control[_control]){				
										if(_user_input == Input.mouse_and_keyboard_and_gamepad){
											_user_input_control_key = input[Input.mouse_and_keyboard][InputProperty.key];
											_user_input_control_key_gamepad = input[Input.gamepad][InputProperty.key];
								
											_user_input_control_sprite_gamepad = input[Input.gamepad][InputProperty.sprite];
								
											if(_user_gamepad_using){
												_user_input_control_sprite = input[Input.gamepad][InputProperty.sprite];
											}
											else{
												_user_input_control_sprite = input[Input.mouse_and_keyboard][InputProperty.sprite];
											}
										}
										else{
											_user_input_control_key = input[_user_input][InputProperty.key];
											_user_input_control_sprite = input[_user_input][InputProperty.sprite];
										}
									}
									
									_user_control_pushed = input_current[_control];
								}
			
								////Check Different Inputs
								//switch(_user_input){
								//	case Input.keyboard:
								//		_user_control_pushed = keyboard_check(_user_input_control_key);
								//	break;
						
								//	case Input.mouse_and_keyboard:
								//		_user_control_pushed = input_check_keyboard_mouse(_user_input_control_key);
								//	break;
						
								//	case Input.mouse:
								//		_user_control_pushed = mouse_check_button(_user_input_control_key);
								//	break;
						
								//	case Input.gamepad:
								//		_user_control_pushed = gamepad_button_check(_user_input_device,_user_input_control_key);
								//	break;
						
								//	case Input.mouse_and_keyboard_and_gamepad:
								//		_user_control_pushed = (input_check_keyboard_mouse(_user_input_control_key) || gamepad_button_check(_user_input_device,_user_input_control_key_gamepad));
								//	break;
								//}
							}
							
							//Button Pushed
							if(_user_control_pushed || (indicator_object_contributing_to_down_time && enable_input)){
								//If Down Time Required
								if((down_time_required > 0) && (down_time_current < down_time_required)){
									if(!indicator_object_contributing_to_down_time){
										//Increase Down Time
										down_time_current += global.delta_time_factor;
									}
										
									//Interaction State Script
									if(state_script[InteractSpaceState.down] != noone){
										_interaction_state_script = state_script[InteractSpaceState.down];
										_interaction_state_script_user_id = _i;
							
										with(_interact_instance){
											if(_interaction_state_script != noone){
												script_execute(_interaction_state_script,_interaction_state_script_user_id,_interaction);
											}
										}
									}
								}
								//Otherwise Go Straight to Active
								else{
									//State to Down
									_state_target = InteractSpaceState.active;
								}
		
								//Finished with State
								_state_stop = true;
							}
	
							//Button Not Pushed
							if(!_user_control_pushed && !indicator_object_contributing_to_down_time){
								//Reduce Down Time Current
								if((down_time_current > 0) && (down_time_reduce_speed != 0)){
									if(down_time_reduce_speed == INTERACT_DOWN_TIME_REDUCE_SPEED_INSTANT){
										down_time_current = 0;
									}
									else{
										down_time_current -= down_time_reduce_speed * global.delta_time_factor;
									}
			
									if(down_time_current < 0)
										down_time_current = 0;
								}
							}
							
							if((indicator_object_contributing_to_down_time && enable_input))
								_user_control_pushed = true;
								
							//If Control Pushed
							//AND
							//Any User Control Pushed is Still False
							if((_user_control_pushed) && (!_any_user_control_pushed)){
								//Flag Any User Control Pushed as True
								_any_user_control_pushed = true;
							}
						
							//If User Control Pushed Mark User as Active
							other.user_active[_i] = _user_control_pushed;
							
							//If User Control Pushed Flag as Active Interaction for User
							if(_user_control_pushed)
								other.user_active_interaction[_i] = _j;
						
							//Update Indicator Poster/Object Key Sprite
							with(indicator_instance){
								key_sprite = _user_input_control_sprite;
							}
						}
						else{
							//Reduce Down Time Current
							if((down_time_current > 0) && (down_time_reduce_speed != 0)){
								if(down_time_reduce_speed == INTERACT_DOWN_TIME_REDUCE_SPEED_INSTANT){
									down_time_current = 0;
								}
								else{
									down_time_current -= down_time_reduce_speed * global.delta_time_factor;
								}
			
								if(down_time_current < 0)
									down_time_current = 0;
							}
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
	
	//No User Control is Pushed
	if(!_any_user_control_pushed){
		//Reset Attack Trigger
		interact_attack_trigger = false;
		
		//No Player in Position
		if(!_player_in_position){
			//State to Idle
			_state_target = InteractSpaceState.idle;
		}
		else{
			//State to Hover
			_state_target = InteractSpaceState.hover;
		}
		
		//Finished with State
		_state_stop = true;
	}
	
	//Set State
	if(_state_stop && (_state_target != noone))
		interact_space_state_set(_state_target);
	
	//Custom Script
	var _stage;
	_stage = (_state_stop)? InteractSpaceStateStage.stop : InteractSpaceStateStage.main;
	interact_space_state_script_stage_execute(_state_current,_stage);
}
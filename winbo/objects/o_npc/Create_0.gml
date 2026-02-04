// Inherit the parent event
event_inherited();

//Team
team = Team.npc;

//States
enum NPCState{
	create,
	idle,
	move,
	death,
	destroy
}

state = NPCState.create;

death_state = NPCState.death;

#region Movement
	movement_velocity_retention_and_acceleration_max_set(0.7,1000);
	movement_input_move_acceleration_default_set(0);
#endregion

#region Lighting
	tracking_light = lighting_light_create_track(spr_light_circular,c_white,"lyr_lighting",1,1,0,0,0,1);
#endregion

#region Interact System Setup
	var _space,_interaction;
	
	//Enable Interact by Default
	interact_enable = true;
	
	//Interaction Enum
	enum NPCInteraction{
		dialogue,
		
		SIZE
	}
	
	interact_active_script[NPCInteraction.dialogue] = noone;
	
	//Main Space
	_space = interact_system_create_space(NPCInteraction.SIZE);
	with(_space){
		#region Space Setup
			//Name
			name = "INTERACT SPACE";
	
			#region Users
				//Position
				user_position = InteractUserPosition.range;
				user_position_x = 0;
				user_position_y = 0;
				user_position_x2 = 0;
				user_position_y2 = 0;
				user_position_range = 1000;
			#endregion
	
			#region Indicators
				//Anchor
				indicator_anchor_x = 0;
				indicator_anchor_y = 0;
				indicator_anchor_position_relative_to_interactor = false;
				indicator_anchor_group_distribution_script = anchor_interact_group_distribution_list_horizontal;
				
				//GUI
				indicator_gui = false;	//Whether the indicators use the GUI or not
			#endregion
			
			#region State Scripts
				var _state;		
				_state = InteractSpaceState.active;
				state_script[_state][InteractSpaceStateStage.main] = noone;
			#endregion
		#endregion
		
		#region Interactions Setups
			interact_space_interaction_setup = function(_space,_user_id){
				var _interaction;
				var _active_script;
				
				//Dialogue
				_interaction =  new InteractSpaceInteraction(_space);
				interaction[_user_id][NPCInteraction.dialogue] = _interaction;
				_active_script = other.interact_active_script[NPCInteraction.dialogue];
				with(_interaction){	
					//Control
					control = UserControl.interact;
					control_pressed_required = true;
		
					//Title
					title_string = "TALK";
					subtitle_string = "HOLD";
		
					//Icon
					icon = noone;
		
					//Indicator
					indicator_part_of_group = false;
					indicator_position_relative_to_interactor = true;	//Only considered if indicator_part_of_group is false
					indicator_x = 0;
					indicator_y = -50;
					indicator_object = o_pstr_interact_indicator;
		
					//Scripts
					state_script[InteractSpaceState.active] = _active_script;
				
					//Activation Indicator Reset
					on_active_remove_indicator = true;
		
					//Down Time
					down_time_required = 0.5 * SECOND;
					down_time_reduce_speed = 2;//INTERACT_DOWN_TIME_REDUCE_SPEED_INSTANT;
					down_time_attack_contribution = down_time_required;
	
					#region Indicator
						//Key
						indicator_enable = true;
	
						//Down Time
						indicator_down_time_enable = true;
						indicator_down_time_x = 0;
						indicator_down_time_y = 100;
					#endregion
				}
			}
		#endregion
	}
#endregion
// Inherit the parent event
event_inherited();

//Sprite Current
sprite_current = sprite_index;

#region Title
	//Title
	title_enable = true;
	title_string = "shop item";
	title_font = fnt_default_30;
	title_x = 0;
	title_y = -100;
	title_colour = c_white;
	title_shadow_colour = c_black;
	title_shadow_enable = true;
	title_shadow_x = -4;
	title_shadow_y = 4;
	
	//Subitle
	subtitle_enable = false;
	subtitle_string = "";
	subtitle_font = fnt_default_24;
	subtitle_x = 0;
	subtitle_y = 150;
	subtitle_colour = c_white;
	subtitle_shadow_colour = c_black;
	subtitle_shadow_enable = true;
	subtitle_shadow_x = -3;
	subtitle_shadow_y = 3;
	
	//Always Show Subtitle
	subtitle_show_always = false;
#endregion

#region Shop
	//Setup as Shop Object
	shop_system_shop_object_create();
	
	//Icon Position
	shop_item_icon_x = -50;
	shop_item_icon_y = 0;
#endregion

#region Interact System Setup
	var _space,_interaction;
	
	//Interaction Enum
	enum ShopInteraction{
		buy,
		equip,
		
		SIZE
	}
	
	#region Indicator Title Strings
		#region Title
			//Title
			interact_purchase_indicator_title_string_unlock = "UNLOCK";
			interact_purchase_indicator_title_string_upgrade = "UPGRADE";
		
			interact_purchase_indicator_subtitle_string_default = "HOLD";
			interact_purchase_indicator_subtitle_string_allow_check_fail = "CAN'T BUY";
			interact_purchase_indicator_subtitle_string_cant_afford = "CAN'T AFFORD";
			interact_purchase_indicator_subtitle_string_max_level = "MAX LEVEL";
		#endregion
		
		#region Equip
			
		#endregion
	#endregion
	
	//Main Space
	_space = interact_system_create_space(ShopInteraction.SIZE);
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
				user_position_range = 500;
			#endregion
	
			#region Indicators
				//Anchor
				indicator_anchor_x = 150;
				indicator_anchor_y = 25;
				indicator_anchor_position_relative_to_interactor = false;
				indicator_anchor_group_distribution_script = anchor_interact_group_distribution_list_horizontal;
				
				//GUI
				indicator_gui = false;	//Whether the indicators use the GUI or not
			#endregion
			
			#region State Scripts
				var _state;
				_state = InteractSpaceState.idle;
				state_script[_state][InteractSpaceStateStage.main] = interact_shop_item_interact_state_idle_main;
		
				_state = InteractSpaceState.hover;
				state_script[_state][InteractSpaceStateStage.start] = interact_shop_item_interact_state_hover_main;
				state_script[_state][InteractSpaceStateStage.main] = interact_shop_item_interact_state_hover_main;
		
				_state = InteractSpaceState.active;
				state_script[_state][InteractSpaceStateStage.main] = noone;
			#endregion
		#endregion
		
		#region Interactions Setups
			interact_space_interaction_setup = function(_space,_user_id){
				var _interaction;
				
				//PURCHASE
				_interaction =  new InteractSpaceInteraction(_space);
				interaction[_user_id][ShopInteraction.buy] = _interaction;
				with(_interaction){	
					//Control
					control = UserControl.interact;
					control_pressed_required = true;
		
					//Title
					title_string = "BUY";
					subtitle_string = "HOLD";
		
					//Icon
					icon = noone;
		
					//Indicator
					indicator_part_of_group = true;
					indicator_position_relative_to_interactor = false;	//Only considered if indicator_part_of_group is false
					indicator_x = 0;
					indicator_y = 0;
					indicator_object = o_pstr_interact_indicator;
		
					//Scripts
					script_down = noone;
					script_active = interact_shop_item_interact_purchase_active;
				
					//Activation Indicator Reset
					on_active_remove_space_indicator_anchor = true;
		
					//Down Time
					down_time_required = 0.5 * SECOND;
					down_time_reduce_speed = 1;//INTERACT_DOWN_TIME_REDUCE_SPEED_INSTANT;
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
			
				//EQUIP
				var _equip_enable;
				_equip_enable = other.shop_item_data.equip_enable;
				
				_interaction =  new InteractSpaceInteraction(_space);
				interaction[_user_id][ShopInteraction.equip] = _interaction;
				with(_interaction){	
					//Enable
					enable = _equip_enable;
					
					//Control
					control = UserControl.interact_equip;
					control_pressed_required = true;
		
					//Title
					title_string = "EQUIP";
					subtitle_string = "HOLD";
		
					//Icon
					icon = noone;
		
					//Indicator
					indicator_part_of_group = false;
					indicator_position_relative_to_interactor = true;	//Only considered if indicator_part_of_group is false
					indicator_x = 0;
					indicator_y = 0;
					indicator_object = o_pstr_interact_indicator;
		
					//Scripts
					script_down = noone;
					script_active = interact_shop_item_interact_equip_active;
				
					//On Active Indicator Rules
					on_active_remove_indicator = true;
					on_active_remove_space_indicator_anchor = false;
		
					//Down Time
					down_time_required = 0.2 * SECOND;
					down_time_reduce_speed = 1;//INTERACT_DOWN_TIME_REDUCE_SPEED_INSTANT;
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

//Light
light = lighting_light_create_track(spr_light_circular,c_white,"lyr_lighting",1,1,0,0,0,1);
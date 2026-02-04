function interact_shop_item_interact_state_hover_main(){
	//Enable Subtitle Description
	subtitle_enable = true;
	
	//Update Cost Title Target
	cost_title_x_target = cost_title_x_target_interaction;
	cost_title_y_target = cost_title_y_target_interaction;
	
	//Cost Factor Update
	shop_system_shop_object_cost_factor_update();
	
	//Cost Can Afford Update
	shop_system_shop_object_cost_can_afford_update();
	
	//Unlock Check
	var _unlocked;
	_unlocked = shop_item_data.unlocked;
	
	//Level Below Max Check
	var _shop_item_level,_level_below_max;
	_shop_item_level = shop_item_data.level;
	_level_below_max = true;
	if((purchase_item_level_increase) && (_shop_item_level >= shop_item_data.level_max)){
		_level_below_max = false;
	}
	
	#region Check if Possible to Purchase
		var _user_can_buy;
		var _user_team;
		
		var _cost_can_afford_array,_cost_can_afford;
		_cost_can_afford_array = cost_can_afford_all;
		
		var _purchase_allow,_purchase_allow_check_script;
		_purchase_allow_check_script = purchase_allow_check_script;
		
		var _purchase_interaction_title_string,_purchase_interaction_subtitle_string;
		
		//Update Purchase Interaction
		with(interact_space[0]){
			for(var _i=0;_i<USER_NUM_MAX;_i++){
				//Reset User Can Buy to True by Default
				_user_can_buy = true;
				
				//Can't Buy if Locked
				if(!_unlocked)
					_user_can_buy = false;
					
				//Needs to be Below Max
				if(!_level_below_max)
					_user_can_buy = false;
					
				//Get User Team
				_user_team = o_input.user[_i].team;
					
				//Needs to be Able to Afford
				_cost_can_afford = _cost_can_afford_array[@ _user_team];
				if(!_cost_can_afford)
					_user_can_buy = false;
				
				//Purchase Allow Check
				_purchase_allow = true;
				if(_purchase_allow_check_script != noone){
					_purchase_allow = script_execute(_purchase_allow_check_script,_i);
					if(!_purchase_allow)
						_user_can_buy = false;
				}
				
				#region Determine Title Strings
					#region Title
						//Level is 0
						if(_shop_item_level <= 0){
							//Unlock String Update
							_purchase_interaction_title_string = other.interact_purchase_indicator_title_string_unlock;
						}
						else{
							//UPGRADE String Update
							_purchase_interaction_title_string = other.interact_purchase_indicator_title_string_upgrade;
						}
					#endregion
		
					#region Subtitle
						//Can Buy
						if(_user_can_buy){
							//UPGRADE String Update
							_purchase_interaction_subtitle_string = other.interact_purchase_indicator_subtitle_string_default;
						}
						//Can't Buy
						else{
							//Level is Below Max
							if(_level_below_max){
								//Can't Purchase String Update
								if(!_purchase_allow){
									_purchase_interaction_subtitle_string = other.interact_purchase_indicator_subtitle_string_allow_check_fail;
								}
								//Cant Afford String Update
								else if(!_cost_can_afford){
									_purchase_interaction_subtitle_string = other.interact_purchase_indicator_subtitle_string_cant_afford;
								}
							}
							else{
								//Max Level String Update
								_purchase_interaction_subtitle_string = other.interact_purchase_indicator_subtitle_string_max_level;
							}
						}
					#endregion
				#endregion
				
				with(interaction[_i][ShopInteraction.buy]){
					//Update Title Strings
					title_string = _purchase_interaction_title_string;
					subtitle_string = _purchase_interaction_subtitle_string;
					
					//Can Buy
					if(_user_can_buy){
						//Title Colour
						title_colour = c_white;
						
						//Input
						enable_input = true;
						indicator_control_key_draw_enable = true;
					}
					//Cant Buy
					else{
						//Title Colour
						title_colour = c_flat_red_monza;
						
						//Input
						enable_input = false;
						indicator_control_key_draw_enable = false;
					}
				}
			}
		}
	#endregion
	
	#region Check if Possible to Equip
		//Equip Enabled
		if(shop_item_data.equip_enable){
			//Shop Item Is Level 0 (Not Purchased Yet)
			if(shop_item_data.level == 0){
				//Update Equip Interaction
				with(interact_space[0]){
					for(var _i=0;_i<USER_NUM_MAX;_i++){
						with(interaction[_i][ShopInteraction.equip]){
							enable = false;
							//enable_input = false;
						}
					}
				}
			}
			else{
				//Update Equip Interaction
				var _equip_allow,_equip_allow_check_script;
				_equip_allow_check_script = equip_allow_check_script
				with(interact_space[0]){
					for(var _i=0;_i<USER_NUM_MAX;_i++){
						//Check if User Is Allowed to Equip
						_equip_allow = true;
						if(_equip_allow_check_script != noone){
							_equip_allow = script_execute(_equip_allow_check_script,_i);
						}
						
						with(interaction[_i][ShopInteraction.equip]){
							//Enable Interaction
							enable = true;
							
							if(_equip_allow){
								//Enable Input
								enable_input = true;
								indicator_control_key_draw_enable = true;
								
								title_string = "EQUIP";
								title_colour = c_white;
				
								//subtitle_string = "";
							}
							else{
								//Disable Input
								enable_input = false;
								indicator_control_key_draw_enable = false;
								
								title_string = "CAN'T EQUIP";
								title_colour = c_flat_red_monza;
				
								//subtitle_string = "";
							}
						}
					}
				}
			}
		}
	#endregion
}
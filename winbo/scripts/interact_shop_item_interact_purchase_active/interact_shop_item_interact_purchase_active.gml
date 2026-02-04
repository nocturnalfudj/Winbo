/// @function interact_shop_item_interact_purchase_active
/// @summary Handle shop item purchase interactions for a user.
function interact_shop_item_interact_purchase_active(_user_id){
	//Get User Team
	var _user_team;
	_user_team = o_input.user[_user_id].team;
	
	#region Cost
		//Default to Failed Purchase
		var _cost_purchase_success;
		_cost_purchase_success = false;
		
		//Cost Can Afford Update
		shop_system_shop_object_cost_can_afford_update();
		
		//Can Afford
		if(cost_can_afford_all[_user_team]){
			if(!free){
				var _resource_cost;
				for(var _i=0;_i<Resource.SIZE;_i++){
					_resource_cost = shop_item_data.cost[_i] * shop_cost_factor[_i];
					o_director.resource[_i][_user_team] -= _resource_cost;
				}
			}
			
			//Purchase Success
			_cost_purchase_success = true;
		}
	#endregion
	
	//Exit if Purchase Failed
	if(_cost_purchase_success == false){
		return false;
	}
	
	//Increase Level of Item by 1
	if(purchase_item_level_increase){
		with(shop_item_data){
			level += 1;
			level = min(level_max,level);
			
			for(var _i=0;_i<Resource.SIZE;_i++){
				cost[_i] = cost_level[level][_i];
			}
		}
		//Update Titles
		title_string = shop_item_data.name;
		if((shop_item_data.level_max > 1) && (cost_title_level_string_enable))
			title_string += cost_title_level_string + string(shop_item_data.level);
		//subtitle_string = "UPGRADE";
	}
	
	#region Merchant Safe
		//Merchant Safe Must Exist
		//can then be assumed the game is in the shop and the cash flow UX is desired
		if(instance_number(o_interact_merchant_safe) > 0){
			//Update Safe
			with(o_interact_merchant_safe){
				if(sprite_current != spr_merchant_safe_open){
					//Flash
					flash_alpha = 1;
				
					//Pulse
					transform_animate_pulse(,1.2);
				
					//Change Sprite
					sprite_current = spr_merchant_safe_open;
				}
			}
			
			//Get Interacting User Player Instance
			var _player_instance;
			_player_instance = o_input.user[_user_id].player_instance;
			
			//Spawn Resource Transfer Posters
			var _resource_transfer,_resource_transfer_poster_count;
			_resource_transfer_poster_count = 3;
			for(var _i=0;_i<_resource_transfer_poster_count;_i++){
				_resource_transfer = instance_create_layer(_player_instance.x,_player_instance.y,"lyr_pfx_foreground",o_pstr_resource_transfer);
				with(_resource_transfer){
					//Animation Position
					animation_order_position = _i;
					animation_order_total = _resource_transfer_poster_count;
					
					//Owner
					owner = _player_instance;
				
					//Target
					target = o_interact_merchant_safe;
				}
			}
		}
	#endregion
	
	//Run Purchase Script
	if(purchase_script != noone){
		script_execute(purchase_script,_user_id);
	}
	
	#region Display Objects
		//Update Cash Display
		with(o_display_cash){
			title_string = "$ " + string(o_director.resource[Resource.cash][_user_team]);
		}
		
		//Update Premium Cash Display
		with(o_display_premium_cash){
			title_string = string(o_director.resource[Resource.premium_cash][_user_team]);
		}
	#endregion
	
	//Free Reset
	if(free_reset_on_purchase){
		free = false;
	}
	
	//Successful Purchase
	return true;
}
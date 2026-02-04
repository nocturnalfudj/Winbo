/// @function xp_add
/// @summary Add experience points to the player and handle level ups.
/// @param _xp_add Amount of XP to add (can be negative).
/// @returns {void} No return value.
/// @description
///   Call when the player earns or loses XP. The script modifies
///   the global `o_director` object to track levels and XP totals.
function xp_add(_xp_add){
        // Manipulate global progression variables stored on the director
        with(o_director){
		//Increase Stat
		//TODO - Add Stat system
		//stat_add(stat[Stat.xp],_xp_add);
		
		//Increase XP
		xp += _xp_add;
		
		#region XP Removed
			if(_xp_add < 0){
				xp_level = 0;
				xp_level_cost_previous = 0;
				xp_level_cost_next = xp_level_cost_base;
			
                                // Recalculate level when XP has dropped
                                while(xp >= xp_level_cost_next){
                                        //Increase XP Level
                                        xp_level++;

                                        //Update XP Level Costs
                                        xp_level_cost_previous = xp_level_cost_next;
                                        xp_level_cost_next = xp_level_cost_base * power(xp_level_cost_factor,xp_level);
                                }
			}
		#endregion
		
		#region Level Up Check
			//Check if Next XP Level Cost Reached
                        // Handle multiple level ups if the added XP spans several levels
                        while(xp >= xp_level_cost_next){
                                //Increase XP Level
                                xp_level++;

                                //Survival Reward Count Increase
                                survival_reward_remaining_count++;

                                //Update XP Level Costs
                                xp_level_cost_previous = xp_level_cost_next;
                                xp_level_cost_next = xp_level_cost_base * power(xp_level_cost_factor,xp_level);
                        }
		#endregion
	}
	
	#region XP Text Poster
		//var _damage_text_poster,_text_poster_x,_text_poster_y;
		//with(o_player){
		//	_text_poster_x = x + irandom_range(-50,50);
		//	_text_poster_y = y + irandom_range(-50,50);
			
		//	_damage_text_poster = instance_create_layer(_text_poster_x,_text_poster_y,"lyr_pfx_foreground",o_txtPstr_xp);
		//	with(_damage_text_poster){
		//		text_string = string(_xp_add);
		
		//		if(_xp_add < 5){
		//			font = fnt_default_30;
		//		}
		//		else if(_xp_add < 15){
		//			font = fnt_default_42;
		//		}
		//		else if(_xp_add < 30){
		//			font = fnt_default_52;
		//		}
		//		else if(_xp_add < 50){
		//			font = fnt_default_64;
		//		}
		//		else{
		//			font = fnt_default_100;
		//		}
		//	}
		//}
	#endregion
}
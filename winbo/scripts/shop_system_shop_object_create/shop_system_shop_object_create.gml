/// @function shop_system_shop_object_create
/// @summary Initialise fields for a shop object instance.
/// @returns {void}
function shop_system_shop_object_create(){
	//Data
	shop_item_data = noone;
	
	#region Cost
		for(var _i=0;_i<Resource.SIZE;_i++){
			for(var _j=0;_j<Team.npc;_j++){
				cost_can_afford[_i][_j] = false;
				cost_can_afford_all[_j] = false;
			}
		}
		
		//Free
		free = false;
		free_reset_on_purchase = true;
		
		//Instance Cost Factor
		//this is meant for this specific instance of the shop
		for(var _i=0;_i<Resource.SIZE;_i++){
			shop_cost_factor_instance[_i] = 1;
		}
		
		//Cost Factor
		shop_system_shop_object_cost_factor_update();
	#endregion
	
	#region Cost Title
		cost_title_enable = true;
		cost_title_font = fnt_default_16;
		cost_title_colour = c_white;
		cost_title_halign = fa_center;
		cost_title_valign = fa_middle;
		cost_title_x = 0;
		cost_title_y = 125;
		cost_title_x_target = cost_title_x;
		cost_title_y_target = cost_title_y;
		cost_title_x_target_idle = cost_title_x;
		cost_title_y_target_idle = cost_title_y;
		cost_title_x_target_interaction = 150;
		cost_title_y_target_interaction = 100;
		cost_title_x_sep = 100;
		cost_title_y_sep = 0;
		cost_title_colour = c_white;
		cost_title_shadow_enable = true;
		cost_title_shadow_alpha = 1;
		cost_title_shadow_colour = c_black;
		cost_title_shadow_x = -1;
		cost_title_shadow_y = 1;
		
		//Mark
		cost_title_level_string_enable = true;
		cost_title_level_string = "\nmk.";
	
		//Cost Colours
		cost_title_colour_cant_afford_team = Team.player;
		cost_title_colour_cant_afford = c_flat_red_monza;
		
		for(var _i=0;_i<Resource.SIZE;_i++){
			cost_title_colour_can_afford[_i] = c_flat_yellow_candy_corn;
			cost_title_icon[_i] = noone;
			cost_title_icon_scale[_i] = 0.4;
		}
		cost_title_colour_can_afford[Resource.cash]			= c_flat_green_malachite;
		cost_title_colour_can_afford[Resource.premium_cash] = c_flat_yellow_candy_corn;
		
		//cost_title_icon[Resource.cash]			= spr_cash_icon;
		//cost_title_icon[Resource.premium_cash]	= spr_premium_cash_icon;
	#endregion
	
	//Icon
	shop_item_icon = noone;
	shop_item_icon_x = 0;
	shop_item_icon_y = 0;
	
	//Draw the Shop Item in Gray if Locked/Unpurchased
	shop_unpurchased_colour_draw_gray_enable = true;
	
	//Purchase
	purchase_script = noone;
	purchase_allow_check_script = noone;
	purchase_item_level_increase = true;
	
	//Equip
	equip_script = noone;
	equip_allow_check_script = noone;
}
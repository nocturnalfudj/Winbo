/// @function interact_shop_item_interact_state_idle_main
/// @summary Default idle update for a shop item interaction state.
/// @returns {void}
function interact_shop_item_interact_state_idle_main(){
	//Cost Factor Update
	shop_system_shop_object_cost_factor_update();
	
	//Cost Can Afford Update
	shop_system_shop_object_cost_can_afford_update();
	
	//Disable Subtitle Description
	if(!subtitle_show_always)
		subtitle_enable = false;
	
	//Update Cost Title Target
	cost_title_x_target = cost_title_x_target_idle;
	cost_title_y_target = cost_title_y_target_idle;
}
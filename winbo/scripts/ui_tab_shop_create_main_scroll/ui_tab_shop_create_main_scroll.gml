/// @function ui_tab_shop_create_main_scroll
/// @summary Create the scrollable container for the shop tab UI.
function ui_tab_shop_create_main_scroll() {
	//UI Group
	ui_group_set(UIGroup.tab_shop,id);

	//GameState Operate
	game_state_operate[GameState.menu] = UIGameStateOperate.full_step;

	//Transform Parent
	transform_parent = o_tab_shop.scroll.transform_child[transform_parent_anchor_child_id];
}
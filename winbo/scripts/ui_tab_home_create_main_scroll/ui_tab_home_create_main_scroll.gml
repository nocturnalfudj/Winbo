/// @function ui_tab_home_create_main_scroll
/// @summary Initialize the home tab scroll container.
/// @returns {void} No return value.
function ui_tab_home_create_main_scroll() {
	//UI Group
	ui_group_set(UIGroup.tab_home,id);

	//GameState Operate
	game_state_operate[GameState.menu] = UIGameStateOperate.full_step;
	
	//Transform Parent
	transform_parent = o_tab_home.scroll.transform_child[transform_parent_anchor_child_id];
}
/// @function ui_tab_home_create_main
/// @summary Create the Home tab container and set parent transforms.
/// @returns {void}
function ui_tab_home_create_main() {
	//UI Group
	ui_group_set(UIGroup.tab_home,id);

	//GameState Operate
	game_state_operate[GameState.menu] = UIGameStateOperate.full_step;
	
	//Transform Parent
	transform_parent = o_tab_home.transform_child[transform_parent_anchor_child_id];
}
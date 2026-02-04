/// @function ui_tab_level_select_create_main
/// @summary Create the Level Select tab container and set parent transforms.
/// @returns {void}
function ui_tab_level_select_create_main() {
	//UI Group
	ui_group_set(UIGroup.tab_level_select,id);

	//GameState Operate
	game_state_operate[GameState.menu] = UIGameStateOperate.full_step;
	
	//Transform Parent
	transform_parent = o_tab_level_select.transform_child[transform_parent_anchor_child_id];
}

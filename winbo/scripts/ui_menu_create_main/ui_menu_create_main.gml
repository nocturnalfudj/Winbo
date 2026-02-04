/// @function ui_menu_create_main
/// @summary Initialise the main menu UI objects.
/// @returns {void} No return value.
function ui_menu_create_main() {
	//UI Group
	ui_group_set(UIGroup.menu,id);

	//GameState Operate
	game_state_operate[GameState.menu] = UIGameStateOperate.full_step;
	
	//Transform Parent
	transform_parent = o_anchor_menu.transform_child[transform_parent_anchor_child_id];
}
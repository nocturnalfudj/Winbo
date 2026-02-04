/// @function ui_pause_create_main
/// @summary Initialize UI elements for the pause menu.
/// @returns {void} No return value.
function ui_pause_create_main() {
	//UI Group
	ui_group_set(UIGroup.pause,id);

	//GameState Operate
	game_state_operate[GameState.pause] = UIGameStateOperate.full_step;
	
	//Transform Parent
	transform_parent = o_anchor_pause.transform_child[transform_parent_anchor_child_id];
}
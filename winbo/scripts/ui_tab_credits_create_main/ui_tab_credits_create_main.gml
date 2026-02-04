/// @function ui_tab_credits_create_main
/// @summary Initialize the Credits tab user interface.
function ui_tab_credits_create_main() {
	//UI Group
	ui_group_set(UIGroup.tab_credits,id);

	//GameState Operate
	game_state_operate[GameState.menu] = UIGameStateOperate.full_step;
	
	//Transform Parent
	transform_parent = o_tab_credits.transform_child[transform_parent_anchor_child_id];
}
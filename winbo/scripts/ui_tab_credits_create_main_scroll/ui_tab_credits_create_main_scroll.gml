/// @function ui_tab_credits_create_main_scroll
/// @summary Initialize the scrollable credits tab UI.
function ui_tab_credits_create_main_scroll() {
	//UI Group
	ui_group_set(UIGroup.tab_credits,id);

	//GameState Operate
	game_state_operate[GameState.menu] = UIGameStateOperate.full_step;

	//Transform Parent
	transform_parent = o_tab_credits.scroll.transform_child[transform_parent_anchor_child_id];
}
/// @function ui_tab_settings_game_create_main_scroll
/// @summary Setup the scroll container for the game settings tab.
function ui_tab_settings_game_create_main_scroll() {
	//UI Group
	ui_group_set(UIGroup.tab_settings_game,id);

	//GameState Operate
	game_state_operate[GameState.menu] = UIGameStateOperate.full_step;
	
	//Transform Parent
	transform_parent = o_tab_settings_game.scroll.transform_child[transform_parent_anchor_child_id];
}
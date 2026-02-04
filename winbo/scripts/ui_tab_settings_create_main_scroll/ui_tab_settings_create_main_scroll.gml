function ui_tab_settings_create_main_scroll() {
	//UI Group
	ui_group_set(UIGroup.tab_settings,id);

	//GameState Operate
	game_state_operate[GameState.menu] = UIGameStateOperate.full_step;
	
	//Transform Parent
	transform_parent = o_tab_settings.scroll.transform_child[transform_parent_anchor_child_id];
}
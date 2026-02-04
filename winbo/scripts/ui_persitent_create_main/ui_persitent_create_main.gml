function ui_persitent_create_main() {
	//UI Group
	ui_group_set(UIGroup.persistent,id);

	//GameState Operate
	game_state_operate[GameState.loading_app]	= UIGameStateOperate.full_step;
	game_state_operate[GameState.menu]		= UIGameStateOperate.full_step;
	game_state_operate[GameState.play]		= UIGameStateOperate.full_step;
	
	//Transform Parent
	transform_parent = o_anchor_persistent.transform_child[transform_parent_anchor_child_id];
}
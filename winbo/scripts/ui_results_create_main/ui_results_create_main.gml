function ui_results_create_main() {
	//UI Group
	ui_group_set(UIGroup.results,id);

	//GameState Operate
	game_state_operate[GameState.start] = UIGameStateOperate.full_step;
	game_state_operate[GameState.play] = UIGameStateOperate.full_step;

	//Transform Parent
	transform_parent = o_anchor_results.transform_child[transform_parent_anchor_child_id];
}
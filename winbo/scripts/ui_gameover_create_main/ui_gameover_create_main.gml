function ui_gameover_create_main() {
	//UI Group
	ui_group_set(UIGroup.gameover,id);

	//GameState Operate
	game_state_operate[GameState.gameover] = UIGameStateOperate.full_step;
	
	//Transform Parent
	transform_parent = o_anchor_gameover.transform_child[transform_parent_anchor_child_id];
}
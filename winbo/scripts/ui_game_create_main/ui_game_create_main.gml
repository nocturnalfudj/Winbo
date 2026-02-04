function ui_game_create_main() {
	//UI Group
	ui_group_set(UIGroup.game,id);

	//GameState Operate
	game_state_operate[GameState.start] = UIGameStateOperate.full_step;
	game_state_operate[GameState.play] = UIGameStateOperate.full_step;
	game_state_operate[GameState.gameover] = UIGameStateOperate.full_step;
	game_state_operate[GameState.pause] = UIGameStateOperate.nothing;
	
	//Transform Parent
	transform_parent = o_anchor_game.transform_child[transform_parent_anchor_child_id];
}
function ui_advert_create_main() {
	//UI Group
	ui_group_set(UIGroup.advert,id);

	//GameState Operate
	game_state_operate[GameState.pause] = UIGameStateOperate.full_step;
	
	//Transform Parent
	transform_parent = o_anchor_advert.transform_child[transform_parent_anchor_child_id];
}
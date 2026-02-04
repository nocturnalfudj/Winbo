/// @function ui_hud_create_main
/// @summary Create and initialize the heads-up display group.
function ui_hud_create_main() {
	//UI Group
	ui_group_set(UIGroup.hud,id);

	//GameState Operate
	game_state_operate[GameState.start] = UIGameStateOperate.full_step;
	game_state_operate[GameState.play] = UIGameStateOperate.full_step;

	//Transform Parent
	transform_parent = o_anchor_hud.transform_child[transform_parent_anchor_child_id];
}
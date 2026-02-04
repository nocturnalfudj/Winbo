/// @function ui_tab_settings_input_create_main
/// @summary Create the input settings tab and bind its parent transform.
function ui_tab_settings_input_create_main() {
	//UI Group
	ui_group_set(UIGroup.tab_settings_input,id);

	//GameState Operate
	game_state_operate[GameState.menu] = UIGameStateOperate.full_step;
	
	//Transform Parent
	transform_parent = o_tab_settings_input.transform_child[transform_parent_anchor_child_id];
}
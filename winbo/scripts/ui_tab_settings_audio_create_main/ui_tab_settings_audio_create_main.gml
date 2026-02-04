/// @function ui_tab_settings_audio_create_main
/// @summary Create the Audio settings tab container.
/// @returns {void}
function ui_tab_settings_audio_create_main() {
	//UI Group
	ui_group_set(UIGroup.tab_settings_audio,id);

	//GameState Operate
	game_state_operate[GameState.menu] = UIGameStateOperate.full_step;
	
	//Transform Parent
	transform_parent = o_tab_settings_audio.transform_child[transform_parent_anchor_child_id];
}
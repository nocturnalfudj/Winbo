/// director_room_finalize_gameplay()
/// @param {struct} _request Active gameplay transition request.
/// @returns {bool} True when destination finalization is complete.
function director_room_finalize_gameplay(_request) {
	// Gameplay rooms should always leave non-gameplay overlays behind.
	with(o_anchor_menu){
		instance_destroy();
	}
	with(o_anchor_pause){
		instance_destroy();
	}
	with(o_anchor_dialogue){
		instance_destroy();
	}
	with(o_anchor_results){
		instance_destroy();
	}
	with(o_anchor_gameover){
		instance_destroy();
	}
	
	if(instance_exists(o_ui) && _request.target_game_state == GameState.play){
		with(o_ui){
			ui_anchor_create(o_anchor_hud, "lyr_hud");
			ui_anchor_create(o_anchor_game, "lyr_pfx_midground");
		}
	}

	if(_request.target_room == r_opening_cutscene) {
		// Match gameplay rendering: director Draw Begin backgrounds, normal actor
		// Draw on lyr_player, then the director's normal foreground pass.
		instance_create_layer(0,0,"lyr_player",o_opening_cutscene_controller);
	}

	if(_request.target_room == r_game_level_0 || _request.target_room == r_game_level_1) {
		instance_create_layer(0,0,"lyr_spawner",o_floating_decor_controller);
	}
	
	with(o_director){
		level_transitioning = false;
	}
	
	return true;
}

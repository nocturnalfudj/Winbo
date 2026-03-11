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
	
	with(o_director){
		level_transitioning = false;
	}
	
	return true;
}

/// director_room_exit_gameplay()
/// @param {struct} _request Active gameplay transition request.
/// @returns {bool} True when teardown is complete.
function director_room_exit_gameplay(_request) {
	with(o_director){
		level_transitioning = true;
	}
	
	// Clear room-specific overlays before the room hop so they cannot bleed into the destination.
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
	
	return true;
}

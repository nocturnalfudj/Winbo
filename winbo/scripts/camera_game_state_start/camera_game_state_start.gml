/// @function camera_game_state_start
/// @summary Reset zoom anchors when the game state begins.
function camera_game_state_start() {
	if(game_state_previous != global.game_state){
		// Move the gameplay camera back onto its normal zoom rest once bootstrap starts.
		zoom_anchor.rest = CAMERA_ZOOM_ANCHOR_PLAY_REST;
		
		var _time_max,_curve;
		_time_max = CAMERA_ZOOM_RECOIL_TIME;
		_curve = CAMERA_ZOOM_RECOIL_CURVE;
			
		transform_value_recoil(zoom_anchor,0,_time_max,_curve);
		transform_value_recoil(zoom_relative,0,_time_max,_curve);
	}

	camera_game_state_default();
}

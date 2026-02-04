/// @function camera_game_state_start
/// @summary Reset zoom anchors when the game state begins.
function camera_game_state_start() {
	//Move State
	//state = CameraState.move;

	#region Zoom Reset
		//Update Zoom Anchor Rest to Menu Value
		zoom_anchor.rest = CAMERA_ZOOM_ANCHOR_PLAY_REST;
		
		var _time_max,_curve;
		_time_max = CAMERA_ZOOM_RECOIL_TIME;
		_curve = CAMERA_ZOOM_RECOIL_CURVE;
			
		//Anchor
		transform_value_recoil(zoom_anchor,0,_time_max,_curve);
			
		//Relative
		transform_value_recoil(zoom_relative,0,_time_max,_curve);
	#endregion
}
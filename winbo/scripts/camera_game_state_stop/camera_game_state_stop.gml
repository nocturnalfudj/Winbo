/// @function camera_game_state_stop
/// @summary Reset the camera when exiting gameplay.
function camera_game_state_stop() {
	state = CameraState.stationary;

	stationary_target.x = width_ini_half;
	stationary_target.y = height_ini_half;

	#region Zoom Reset
		//Update Zoom Anchor Rest to Menu Value
		zoom_anchor.rest = CAMERA_ZOOM_ANCHOR_MENU_REST;
		
		var _time_max,_curve;
		_time_max = CAMERA_ZOOM_RECOIL_TIME;
		_curve = CAMERA_ZOOM_RECOIL_CURVE;
			
		//Anchor
		transform_value_recoil(zoom_anchor,0,_time_max,_curve);
			
		//Relative
		transform_value_recoil(zoom_relative,0,_time_max,_curve);
	#endregion
}
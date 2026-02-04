/// @function camera_game_state_default
/// @summary Update camera behaviour based on the current state.
function camera_game_state_default() {
	switch(state){
		case CameraState.idle:
		break;
	
		case CameraState.stationary:
			camera_state_stationary();
		break;
	
		case CameraState.follow:
			camera_state_follow();
		break;
	
		case CameraState.move:
			camera_state_move();
		break;
	}
	
	//Shake System
	shake_system_update();
	
	//Update Zoom System
	camera_zoom_update();

	//Update Transform system
	camera_transform_system_update();
	
	#region Update Follow Target Difference
		follow_target_difference.x = follow_target.x - x;
		follow_target_difference.y = follow_target.y - y;
	#endregion
}
/// @function camera_state_move
/// @summary Handle zoom and drag behaviour while the camera moves.
function camera_state_move() {
	//Zoom In/Out
	camera_zoom_control();

	if(!zoom_control_pinch_active){
		//Drag & Pan
		movement_drag_pan_update(true,zoom_anchor.current);
	}
	else{
		drag_active = false;
		pan_active = false;
	}
}
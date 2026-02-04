/// Retrieve the camera's intended height for the current orientation.
function camera_get_intended_height(){
	with(o_camera){
		return camera_h_inteded[orientation];
	}
}
/// Retrieve the camera's intended width for the current orientation.
function camera_get_intended_width(){
	with(o_camera){
		return camera_w_inteded[orientation];
	}
}
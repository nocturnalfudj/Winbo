/// @function camera_view_pos_update
/// @summary Center the camera on this instance each frame.
function camera_view_pos_update() {
	var _x,_y;
	_x = x - width_half;
	_y = y - height_half;	
	camera_set_view_pos(view_camera[0],_x,_y);
	camera_center_end_update();
}
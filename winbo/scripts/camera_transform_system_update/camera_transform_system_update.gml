/// @function camera_transform_system_update
/// @summary Synchronize camera transforms with object transforms.
function camera_transform_system_update() {
	transform_system_update();

	//Anchor Relative New Update
	if(transform_updated || zoom_updated){
		//Zoom
		camera_zoom_set_dimensions();
	
		//Angle
		camera_set_view_angle(view_camera[0],image_angle);
	
		//Update Camera Position
		camera_view_pos_update();
	}
}
///@param width
///@param height
function camera_set_resolution(_width,_height) {
	//Reize Window
	camera_resize_window(_width,_height);

	with(o_camera){
		camera_dimensions_update(_width,_height);
		
		camera_zoom_set_dimensions();
	}
	
	//Update GUI Scale Variables
	ui_gui_scale_update(1);
}
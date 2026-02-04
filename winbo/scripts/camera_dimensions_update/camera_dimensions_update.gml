/// Update internal camera dimension variables.
/// @param _width  New camera width
/// @param _height New camera height
function camera_dimensions_update(_width,_height) {
	width = _width;
	height = _height;

	width_ini = width;
	height_ini = height;

	width_half = width/2;
	height_half = height/2;
	width_ini_half = width_ini/2;
	height_ini_half = height_ini/2;
	
	//Pan Edge Scroll Update
	if(variable_instance_exists(id,"pan_edge_scroll_max")){
		pan_edge_scroll_max.Set(width_ini,height_ini);
	}
	
	sdm("camera width : " + string(width));
	sdm("camera height : " + string(height));

	//Update Center and End Variables
	camera_center_end_update();
}
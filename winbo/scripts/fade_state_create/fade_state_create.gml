/// @function fade_state_create
/// @summary Initialise variables when creating a fade UI element.
/// @returns {void}
function fade_state_create(){
	//State to Idle
	ui_object_state_set(UIState.idle);
			
	//Transform Update Scale
	transform_system_update_scale();
			
	#region Fade Dimensions
		bounding_box_width = width;
		bounding_box_height = height;
	
		width = bounding_box_width * image_xscale;
		height = bounding_box_height * image_yscale;
	
		width_half = width/2;
		height_half = height/2;
	#endregion
			
	//Camera Visible Dimensions
	camera_visible_dimensions();
}
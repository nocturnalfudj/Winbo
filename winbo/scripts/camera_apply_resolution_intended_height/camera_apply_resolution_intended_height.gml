/// @function camera_apply_resolution_intended_height
/// @summary Resize the window while keeping the intended camera height constant.
/// @param _width Actual window width.
/// @param _height Actual window height.
/// @returns {void}
function camera_apply_resolution_intended_height(_width,_height) {
	var _aspect_ratio;
	_aspect_ratio = _width/_height;

	//Reize Window
	camera_resize_window(_width,_height);

	var _height_intended;
	var _width_new,_height_new;

	with(o_camera){
		_height_intended = camera_get_intended_height();
	
		_height_new = _height_intended;
		_width_new = _height_new*_aspect_ratio;
	
		camera_dimensions_update(_width_new,_height_new);
		
		camera_zoom_set_dimensions();
	}
	
	#region UI Update
		//Update GUI Scale Variables
		ui_gui_scale_update(_height/_height_intended);
		
		if(room != r_boot)
			ui_reset_menu();
		
		console_new_resolution();
	#endregion
}
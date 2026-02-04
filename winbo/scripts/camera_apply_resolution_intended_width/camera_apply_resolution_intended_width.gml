/// Resize the window keeping the intended width constant.
/// @param _width  Actual window width
/// @param _height Actual window height
function camera_apply_resolution_intended_width(_width,_height) {
	var _aspect_ratio;
	_aspect_ratio = _height/_width;

	//Reize Window
	camera_resize_window(_width,_height);

	var _width_intended,_height_intended;
	var _width_new,_height_new;

	with(o_camera){
		_width_intended = camera_get_intended_width();
		_height_intended = camera_get_intended_height();
	
		_width_new = _width_intended;
		_height_new = _width_new*_aspect_ratio;
	
		camera_dimensions_update(_width_new,_height_new);
		
		camera_zoom_set_dimensions();
	}
	
	#region UI Update
		//Update GUI Scale Variables
		ui_gui_scale_update(_width/_width_intended);
		
		if(room != r_boot)
			ui_reset_menu();
		
		console_new_resolution();
	#endregion
}
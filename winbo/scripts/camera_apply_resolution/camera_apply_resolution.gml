/// Apply a new resolution to the game window and update UI scaling.
/// @param _width  Target window width
/// @param _height Target window height
function camera_apply_resolution(_width,_height) {
	var _aspect_ratio;
	_aspect_ratio = _width/_height;

	//Reize Window
	camera_resize_window(_width,_height);

	var _width_intended,_height_intended;
	_width_intended = camera_get_intended_width();
	_height_intended = camera_get_intended_height();
	
	var _width_new,_height_new;

	with(o_camera){
		#region Calculate New Width & Height
			//var _div,_ceil,_floor;
		
			//if(_height > _height_intended){
			//	_div = _height/_height_intended;
			//	_ceil = _height / ceil(_div);
			//	_floor = (_div > 1)? (_height / floor(_div)) : _height;
			//}
			//else if(_height < _height_intended){
			//	_div = _height_intended/_height;
			//	_ceil = _height * ceil(_div);
			//	_floor = (_div > 1)? (_height * floor(_div)) : _height;
			//}
			//else{
			//	_ceil = _height;
			//	_floor = _height;
			//}
		
			//if((abs(_height_intended - _floor)) < abs(_height_intended - _ceil))
			//	_height_new = _floor;
			//else
			//	_height_new = _ceil;

			//_width_new = _height_new*_aspect_ratio;
			
			_width_new = _width;
			_height_new = _height;
		#endregion
	
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
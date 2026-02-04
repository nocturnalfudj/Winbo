/// @function camera_visible_check
/// @summary Determine if an instance is visible within the camera view.
/// @param buff_w Optional horizontal buffer around the camera view.
/// @param buff_h Optional vertical buffer around the camera view.
/// @returns {bool} True if the instance is currently visible.
function camera_visible_check(_buff_w,_buff_h) {
	var _x1,_x2,_y1,_y2;
	with(o_camera){
		_x1 = start_x;
		_y1 = start_y;
	
		_x2 = end_x;
		_y2 = end_y;
	}

	// Guard against NaN camera bounds (safety net for rendering)
	if (is_nan(_x1) || is_nan(_y1) || is_nan(_x2) || is_nan(_y2)) {
		camera_visible = true;
		camera_visible_position = true;
		return true;
	}

	if((_buff_w != undefined) && (_buff_h != undefined)){
		_buff_w = _buff_w/2;
		_buff_h = _buff_h/2;
	
		_x1 -= _buff_w;
		_x2 += _buff_w;
	
		_y1 -= _buff_h;
		_y2 += _buff_h;
	}

	if(point_in_rectangle(x,y,_x1,_y1,_x2,_y2)){
		camera_visible_position = true;
	}
	else{	
		camera_visible_position = false;
	}
	
	if(camera_visible_always){
		camera_visible = true;
		return camera_visible;
	}
	
	var _alpha_scale_above_0;
	_alpha_scale_above_0 = true;
	if((image_alpha == 0) || (image_xscale == 0) || (image_yscale == 0)){
		camera_visible = false;
		_alpha_scale_above_0 = false;
	}
	
	if(_alpha_scale_above_0 && camera_visible_position)
		camera_visible = true;
	else
		camera_visible = false;
	
	return camera_visible;
}
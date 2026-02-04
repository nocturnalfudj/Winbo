/// @function camera_visible_check_gui
/// @summary Check GUI element visibility relative to the camera.
/// @param buff_w Horizontal buffer around the window bounds.
/// @param buff_h Vertical buffer around the window bounds.
/// @returns {bool} True if the GUI element is visible.
function camera_visible_check_gui(_buff_w,_buff_h) {
	if(camera_visible_always){
		camera_visible_gui = true;
		return camera_visible_gui;
	}
	
	var _in_window;
	_in_window = (window != noone);
	
	if(hud && (o_ui.hud_enable == false)){
		camera_visible_gui = false;
		return false;
	}	
	
	if((image_alpha == 0) || (image_xscale == 0) || (image_yscale == 0) || ((!_in_window) && (visible == false))){
		camera_visible_gui = false;
		return false;
	}
	
	var _x1,_x2,_y1,_y2;
	if(_in_window){
		with(window){
			//_x1 = x - width_half;
			//_y1 = y - height_half;
			//_x2 = x + width_half;
			//_y2 = y + height_half;
			
			_x1 = x + surface_x;
			_y1 = y + surface_y;
			_x2 = _x1 + surface_width;
			_y2 = _y1 + surface_height;
		}
	}
	else{
		with(o_camera){
			_x1 = 0;
			_y1 = 0;
			_x2 = width_ini;
			_y2 = height_ini;
		}
	}

	if((_buff_w != undefined) && (_buff_h != undefined)){
		_buff_w = _buff_w/2;
		_buff_h =_buff_h/2;
	
		_x1 -= _buff_w;
		_x2 += _buff_w;
	
		_y1 -= _buff_h;
		_y2 += _buff_h;
	}

	if(point_in_rectangle(x,y,_x1,_y1,_x2,_y2)){
		camera_visible_gui = true;
		return true;
	}
	else{
		camera_visible_gui = false;
		return false;
	}
}
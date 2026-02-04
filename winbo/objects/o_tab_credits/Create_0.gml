// Inherit the parent event
event_inherited();

#region Tab Creation
	var _x,_y,_x_center,_y_center,_x_width,_y_height;
	with(o_camera){
		_x_center = width_ini_half;
		_y_center = height_ini_half;
		_x_width = width_ini;
		_y_height = height_ini;
	}
	
	//Credits Poster
	_x = _x_center;
	_y = _y_center;
	instance_create_layer(_x,_y,"lyr_menu",o_pstr_credits);
#endregion
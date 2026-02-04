// Inherit the parent event
event_inherited();

#region Scroll
	with(scroll){
		var _y_min;
		_y_min = y -500;
		position_clamp_min.Set(0,_y_min);
	}
#endregion

#region Tab Creation
	var _x,_y,_x_center,_y_center,_x_width,_y_height;
	with(o_camera){
		_x_center = width_ini_half;
		_y_center = height_ini_half;
		_x_width = width_ini;
		_y_height = height_ini;
	}
#endregion
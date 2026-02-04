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
	
	#region Language
		//ENG UK
		_x = _x_center - 150;
		_y = _y_center;
		instance_create_layer(_x,_y,"lyr_menu",o_txtBtn_language_eng_uk);
	
		//TEST
		_x = _x_center + 150;
		_y = _y_center;
		instance_create_layer(_x,_y,"lyr_menu",o_txtBtn_language_test1);
	#endregion
#endregion
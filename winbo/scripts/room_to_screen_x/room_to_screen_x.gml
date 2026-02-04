function room_to_screen_x(_x){
	with(o_camera){
		_x = (_x - x)/zoom_resultant + width_ini_half;
	}
	
	return _x;
}
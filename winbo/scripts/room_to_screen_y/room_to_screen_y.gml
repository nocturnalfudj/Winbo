function room_to_screen_y(_x){
	with(o_camera){
		_y = (_y - y)/zoom_resultant + height_ini_half;
	}
	
	return _y;
}
function screen_to_room_y(_x){
	with(o_camera){
		_y = ((_y - height_ini_half)*zoom_resultant) + y;
	}
	
	return _y;
}
/// @function screen_to_room_x
/// @summary Convert a screen-space X coordinate to room space.
/// @param _x Screen coordinate.
/// @returns {real} Converted coordinate.
function screen_to_room_x(_x){
	with(o_camera){
		_x = ((_x - width_ini_half)*zoom_resultant) + x;
	}
	
	return _x;
}
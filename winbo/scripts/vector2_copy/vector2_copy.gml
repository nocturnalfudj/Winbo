/// @function vector2_copy
/// @summary Copy the x and y values from one Vector2 struct to another.
/// @param _vector2_destination Struct to receive the values.
/// @param _vector2_source      Struct to copy from.
/// @returns {void} No return value.
function vector2_copy(_vector2_destination,_vector2_source){
	with(_vector2_destination){
		x = _vector2_source.x;
		y = _vector2_source.y;
	}
}
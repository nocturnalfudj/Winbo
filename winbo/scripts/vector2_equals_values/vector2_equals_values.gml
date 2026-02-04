/// @function vector2_equals_values
/// @summary Compare a Vector2 struct against numeric x and y values.
/// @param _vector2 The vector2 instance to compare.
/// @param _x X value to test.
/// @param _y Y value to test.
function vector2_equals_values(_vector2,_x,_y){
	with(_vector2){
		if(x == _x && y == _y)
			return true;
		else
			return false;
	}
	
	return false;
}
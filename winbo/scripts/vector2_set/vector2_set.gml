/// @function vector2_set
/// @summary Assign X and Y values to a Vector2 struct.
/// @param {Vector2} _vector2 - The struct to modify.
/// @param {real} _x - New x value.
/// @param {real} _y - New y value.
function vector2_set(_vector2,_x,_y){
	with(_vector2){
		x = _x;
		y = _y;
	}
}
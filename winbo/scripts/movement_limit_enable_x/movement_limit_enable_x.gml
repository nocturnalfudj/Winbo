/// @function movement_limit_enable_x
/// @summary Constrain movement along the X axis.
/// @param _min Minimum allowed x value.
/// @param _max Maximum allowed x value.
/// @returns {void} No return value.
function movement_limit_enable_x(_min,_max){
	//Enable
	move_limit_enable_x = true;
	
	//Limit Vectors
	move_limit_x = new Vector2(_min,_max);
}
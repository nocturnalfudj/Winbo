/// Check if two vector2 structs contain the same values.
/// @param _vector2_a First vector to compare
/// @param _vector2_b Second vector to compare
function vector2_equals_vector2(_vector2_a,_vector2_b){
	with(_vector2_a){
		if(x == _vector2_b.x && y == _vector2_b.y)
			return true;
		else
			return false;
	}
	
	return false;
}
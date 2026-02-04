/// @function string_is_real
/// @summary Determine if the given string represents a valid real number.
/// @param _string Text to test for numeric characters.
function string_is_real(_string){
	var _digits_length;
	_digits_length = string_length(string_digits(_string));
	
	return (_digits_length > 0) && (_digits_length == string_length(_string) - (string_ord_at(_string, 1) == ord("-")) - (string_pos(".", _string) != 0));
}
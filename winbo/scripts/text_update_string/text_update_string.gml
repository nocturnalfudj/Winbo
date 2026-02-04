/// @function text_update_string
/// @summary Fetch the latest value from a text object.
/// @param {string} _string Destination string.
/// @param _text Text object with a value field.
function text_update_string(_string,_text){
	with(_text){
		_string = value;
	}
	
	return _string;
}
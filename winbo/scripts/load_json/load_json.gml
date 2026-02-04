/// @function load_json
/// @summary Load and decode a JSON file from disk.
/// @param {string} _filename Path to the JSON file.
/// @returns {struct|real} Decoded JSON data or -1 on failure.
function load_json(_filename){
	//If Game is Running in a Browser Return -1
	if(os_browser != browser_not_a_browser)
		return -1;
	
	var _buffer,_json;
	_buffer = buffer_load(_filename);
	if(_buffer == -1)
		return -1;
	
	_json = buffer_read(_buffer,buffer_string);
	buffer_delete(_buffer);
	
	return json_decode(_json);
}
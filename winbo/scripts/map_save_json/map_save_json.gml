function map_save_json(_map,_filename){
	var _json;
	_json = json_encode(_map);
	
	var _buffer;
	_buffer = buffer_create(string_byte_length(_json)+1,buffer_fixed,1);
	buffer_write(_buffer,buffer_string,_json);
	buffer_save(_buffer,_filename);
	buffer_delete(_buffer);
}
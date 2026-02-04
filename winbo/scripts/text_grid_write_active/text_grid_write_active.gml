///@param grid
///@param file_name
function text_grid_write_active(_grid,_name) {
	_name += "/active_sheet.agsts";

	var _width,_height;
	_width = ds_grid_width(_grid);
	_height = ds_grid_height(_grid);

	var _file,_string;
	_file = file_text_open_write(_name);
	_string = "ID,CURRENT,DEFAULT";
	for(var _i=3;_i<_width;_i++){
		_string += ",LANG_" + string(_i-2);
	}
	file_text_write_string(_file,_string);
	file_text_writeln(_file);

	for(var _i=0;_i<_height;_i++){
		_string = string(_grid[# 0,_i]);
		for(var _j=1;_j<_width;_j++){
			_string += ","+string(_grid[# _j,_i])
		}
		file_text_write_string(_file,_string);
		file_text_writeln(_file);
	}
	file_text_close(_file);
}
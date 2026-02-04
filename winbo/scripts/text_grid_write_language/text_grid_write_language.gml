/// @function text_grid_write_language
/// @summary Export a language column from a text grid into a CSV-like file.
/// @param {ds_grid} grid Source text grid.
/// @param {string} lang Target language tag.
/// @param {real} text_group TextGroup enum value.
/// @param {string} file_name Output file name without extension.
/// @returns {void}
function text_grid_write_language(_grid,_language,_text_group,_name) {
	var _width,_height;
	_width = ds_grid_width(_grid);
	_height = ds_grid_height(_grid);

	var _language_column,_language_valid;
	_language_valid = false;
	for(var _i=2;_i<_width;_i++){
		if(_language == _grid[# _i, 0]){
			_language_valid = true;
			_language_column = _i;
		}
	}

	if(!_language_valid) exit;

	var _text_group_txt;
	switch(_text_group){
		case TextGroup.ui:
			_text_group_txt = "ui";
		break;
	}
	_name += "/text_sheet_"+_text_group_txt+"_"+_language+".agsts";

	var _file,_string;
	_file = file_text_open_write(_name);
	_string = "ID,DEFAULT,LANG";
	file_text_write_string(_file,_string);
	file_text_writeln(_file);

	for(var _i=0;_i<_height;_i++){
		//ID
		_string = string(_grid[# 0,_i]);
	
		//DEFAULT
		_string += ","+string(_grid[# 2,_i]);
	
		//LANG
		_string += ","+string(_grid[# _language_column,_i]);
	
		file_text_write_string(_file,_string);
		file_text_writeln(_file);
	}
	file_text_close(_file);
}
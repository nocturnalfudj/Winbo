///@param grid
///@param text_group
///@param file_name
function text_grid_write_template(_grid,_text_group,_name) {
	var _text_group_txt;
	switch(_text_group){
		case TextGroup.ui:
			_text_group_txt = "ui";
		break;
	}
	_name += "/text_sheet_"+_text_group_txt+"_template.agsts";

	var _height;
	_height = ds_grid_height(_grid);

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
	
		//Template
		switch(_i){
			case 0:
				_string += ",[LANGUAGE]";
			break;
		
			case 1:
				_string += ",Author : [AUTHOR]";
			break;
		
			case 2:
				_string += ",Version : [VERSION]";
			break;
		
			case 3:
				_string += ",Date : [DATE]";
			break;
		
			case 4:
				_string += ",[TEXT SHEET NAME]";
			break;
		
			default:
				_string += ","+string(_grid[# 2,_i]);
			break;
		}
	
		file_text_write_string(_file,_string);
		file_text_writeln(_file);
	}
	file_text_close(_file);
}
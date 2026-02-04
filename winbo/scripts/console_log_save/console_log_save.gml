///@param lines
function console_log_save(_lines) {
	var _file,_file_name,_datetime,_day,_month,_year,_hour,_minute,_second;

	#region File Name Date
	_datetime = date_current_datetime();

	_day = string_format(date_get_day(_datetime),2,0);
	_day = string_replace_all(_day," ","0");

	_month = string_format(date_get_month(_datetime),2,0);
	_month = string_replace_all(_month," ","0");

	_year = string(date_get_year(_datetime));

	_hour = string_format(date_get_hour(_datetime),2,0);
	_hour = string_replace_all(_hour," ","0");

	_minute = string_format(date_get_minute(_datetime),2,0);
	_minute = string_replace_all(_minute," ","0");

	_second = string_format(date_get_second(_datetime),2,0);
	_second = string_replace_all(_second," ","0");

	_file_name = "Console Log " + 
			_day + "-" + 
			_month + "-" + 
			_year + " " + 
			_hour + "." + 
			_minute + "." + 
			_second + ".txt";
	#endregion

	_file = file_text_open_write(_file_name);


	var _list_size,_string;
	_list_size = ds_list_size(log);

	if(_lines == "all") _lines = _list_size
	else if(_lines > _list_size) _lines = _list_size

	for(var _i=_lines-1;_i>=0;_i--){
		_string = log[| _i];
		file_text_write_string(_file,_string);
		file_text_writeln(_file);
	}


	file_text_close(_file);
}
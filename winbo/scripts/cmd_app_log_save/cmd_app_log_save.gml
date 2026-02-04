/// @function cmd_app_log_save
/// @summary Save the application log to disk.
/// @param _subject Placeholder argument from console.
/// @param _argument_list Array of command parameters.
function cmd_app_log_save(_subject,_argument_list) {
	var _num,_num_valid,_time,_time_valid;
	_num = _argument_list[| 0];
	_time = _argument_list[| 1];

	_num_valid = false;
	_time_valid = false;

	if(string_lower(_num) == "all"){
		_num_valid = true;
	}
	else if(string_length(string_digits(_num)) == string_length(_num)){
		_num = real(string_digits(_num));
	
		if(_num>0){
			_num_valid = true;
		}
		else{
			sdm("Line number is invalid. Must only contain positive numbers, or be 'all' : " +string(_num),LOG_COLOUR_COMMAND_ERROR);
		}
	}
	else{
		sdm("Line number is invalid. Must only contain positive numbers, or be 'all' : " + _num,LOG_COLOUR_COMMAND_ERROR);
	}

	if(string_lower(_time) == "now"){
		_time = 1;
		_time_valid = true;
	}
	else if(string_lower(_time) == "close"){
		_time = 2;
		_time_valid = true;
	}
	else{
		sdm("Time is invalid. Must be 'now' or 'close' : " + _time,LOG_COLOUR_COMMAND_ERROR);
	}


	if(_num_valid && _time_valid){
		if(_time == 1){
			console_log_save(_num);
			
			sdm("Saved " + string(_num) + " lines of the log",LOG_COLOUR_COMMAND_SUCCESS);
		}
		else if (_time == 2){
			log_save_quit = true;
			log_save_quit_num = _num;
		}
	}
}
function cmd_settings_resolution(_subject,_argument_list){
	var _width,_height;
	_width = _argument_list[| 0];
	_height = _argument_list[| 1];
	
	if(string_is_real(_width)){
		if(string_is_real(_height)){
			_width = real(_width);
			_height = real(_height);
			
			if(_width > 0){
				if(_height > 0){
					camera_set_resolution(_width,_height);
					
					sdm("Resolution set to " + string(_width) + "," + string(_height),LOG_COLOUR_COMMAND_SUCCESS);
				}
				else{
					sdm("Height is invalid, must be larger than 0 : " + string(_height),LOG_COLOUR_COMMAND_ERROR);
				}
			}
			else{
				sdm("Width is invalid, must be larger than 0 : " + string(_width),LOG_COLOUR_COMMAND_ERROR);
			}	
		}
		else{
			sdm("Height is invalid, must be a number larger than 0 : " + _height,LOG_COLOUR_COMMAND_ERROR);
		}
	}
	else{
		sdm("Width is invalid, must be a number larger than 0: " + _width,LOG_COLOUR_COMMAND_ERROR);
	}
}
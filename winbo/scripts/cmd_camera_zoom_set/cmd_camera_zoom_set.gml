function cmd_camera_zoom_set(_subject,_argument_list){
	var _transform,_value,_add_to_current;
	_transform = _argument_list[| 0];
	_value = _argument_list[| 1];
	_add_to_current = _argument_list[| 2];
	
	switch(string_lower(_transform)){
		case "anchor":
			_transform = o_camera.zoom_anchor;
		break;
		
		case "relative":
			_transform = o_camera.zoom_relative;
		break;
		
		default:
			sdm("Argument is invalid, must be anchor/relative : " + _transform,LOG_COLOUR_COMMAND_ERROR);
			exit;
		break;
	}
	
	if(string_is_real(_value)){
		_value = real(_value);
	}
	else{
		sdm("Value Argument is invalid, must be a number : " + _value,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}
	
	if((string_lower(_add_to_current) == "false") || (_add_to_current == "0")){
		_add_to_current = false;
	}
	else if((string_lower(_add_to_current) == "true") || (_add_to_current == "1")){
		_add_to_current = true;
	}
	else{
		sdm("Add to Current Argument is invalid, must be true/false or 1/0 : " + _add_to_current,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}

	with(o_camera){
		transform_value_set(_transform,_value,_add_to_current);
		
		sdm("Camera zoom " + string(_transform) + " set",LOG_COLOUR_COMMAND_SUCCESS);
	}
}
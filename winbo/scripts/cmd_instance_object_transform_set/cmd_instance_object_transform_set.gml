function cmd_instance_object_transform_set(_subject,_argument_list) {
	var _transform,_transform_value,_value,_add_to_current;
	_transform = _argument_list[| 0];
	_transform_value = _argument_list[| 1];
	_value = _argument_list[| 2];
	_add_to_current = _argument_list[| 3];
	
	switch(string_lower(_transform)){
		case "anchor":
			_transform = TransformType.anchor;
		break;
		
		case "relative":
			_transform = TransformType.relative;
		break;
		
		default:
			sdm("Argument is invalid, must be anchor/relative : " + _transform,LOG_COLOUR_COMMAND_ERROR);
			exit;
		break;
	}
	
	switch(string_lower(_transform_value)){
		case "x":
			_transform_value = TransformValue.x;
		break;
		
		case "y":
			_transform_value = TransformValue.y;
		break;
		
		case "xscale":
			_transform_value = TransformValue.xscale;
		break;
		
		case "yscale":
			_transform_value = TransformValue.yscale;
		break;
		
		case "alpha":
			_transform_value = TransformValue.alpha;
		break;
		
		case "angle":
			_transform_value = TransformValue.angle;
		break;
		
		case "colour":
		case "color":
			_transform_value = TransformValue.colour;
		break;
		
		default:
			sdm("Argument is invalid, must be x / y / xscale / yscale / alpha / angle / colour : " + _transform_value,LOG_COLOUR_COMMAND_ERROR);
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
	
	//Convert Subject to Camera if used by Camera
	if(_subject == command_subject[CMDSubject.camera].prefix){
		_subject = o_camera;
	}

	with(_subject){
		if(variable_instance_exists(id,"transform_updated")){
			transform_set(transform[_transform],_transform_value,_value,_add_to_current);
			
			sdm("Transform of instance " + string(id) + " set",LOG_COLOUR_COMMAND_SUCCESS);
		}
		else{
			sdm("Subject doesn't have transform_updated system",LOG_COLOUR_COMMAND_ERROR);
			exit;
		}
	}
}
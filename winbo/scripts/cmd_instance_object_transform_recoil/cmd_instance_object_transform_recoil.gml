function cmd_instance_object_transform_recoil(_subject,_argument_list) {
	var _transform,_transform_value;
	_transform = _argument_list[| 0];
	_transform_value = _argument_list[| 1];
	
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

	//Convert Subject to Camera if used by Camera
	if(_subject == command_subject[CMDSubject.camera].prefix){
		_subject = o_camera;
	}

	with(_subject){
		if(variable_instance_exists(id,"transform_updated")){
			transform_recoil_no_cruve(transform[_transform],_transform_value);
			
			sdm("Transform of instance " + string(id) + " recoiled",LOG_COLOUR_COMMAND_SUCCESS);
		}
		else{
			sdm("Subject doesn't have transform_updated system",LOG_COLOUR_COMMAND_ERROR);
			exit;
		}
	}
}
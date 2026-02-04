/// @function cmd_instance_object_image_loop
/// @summary Toggle an instance's sprite animation looping via console.
/// @param _subject Target instance whose image struct is modified.
/// @param _argument_list Single value specifying true/false or 1/0.
function cmd_instance_object_image_loop(_subject,_argument_list) {
	var _loop;
	_loop = _argument_list[| 0];
	
	if((string_lower(_loop) == "false") || (_loop == "0")){
		_loop = false;
	}
	else if((string_lower(_loop) == "true") || (_loop == "1")){
		_loop = true;
	}
	else{
		sdm("Argument is invalid, must be true/false or 1/0 : " + _loop,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}

	with(_subject){
		if(variable_instance_exists(id,"image")){
			with(image){
				loop = _loop;
				
				sdm("Image loop of instance " + string(id) + " set to " + string(_loop),LOG_COLOUR_COMMAND_SUCCESS);
			}
		}
		else{
			sdm("Subject doesn't have image system",LOG_COLOUR_COMMAND_ERROR);
			exit;
		}
	}
}
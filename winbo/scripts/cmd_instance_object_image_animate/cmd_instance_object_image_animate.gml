/// @function cmd_instance_object_image_animate
/// @summary Console command to toggle image animation on an instance.
/// @param _subject Instance affected by the command.
/// @param _argument_list Arguments from the console.
function cmd_instance_object_image_animate(_subject,_argument_list) {
	var _animate;
	_animate = _argument_list[| 0];
	
	if((string_lower(_animate) == "false") || (_animate == "0")){
		_animate = false;
	}
	else if((string_lower(_animate) == "true") || (_animate == "1")){
		_animate = true;
	}
	else{
		sdm("Argument is invalid, must be true/false or 1/0 : " + _animate,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}

	with(_subject){
		if(variable_instance_exists(id,"image")){
			with(image){
				animate = _animate;
				
				sdm("Image animation of instance " + string(id) + " set to " + string(_animate),LOG_COLOUR_COMMAND_SUCCESS);
			}
		}
		else{
			sdm("Subject doesn't have image system",LOG_COLOUR_COMMAND_ERROR);
			exit;
		}
	}
}
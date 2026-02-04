function cmd_instance_object_image_fps(_subject,_argument_list) {
	var _frames_per_second;
	_frames_per_second = _argument_list[| 0];
	
	if(string_is_real(_frames_per_second)){
		_frames_per_second = real(_frames_per_second);
	}
	else{
		sdm("Argument is invalid, must be a number : " + _frames_per_second,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}

	with(_subject){
		if(variable_instance_exists(id,"image")){
			image_set_fps(image,_frames_per_second);
			
			sdm("Image fps of instance " + string(id) + " set to " + string(_frames_per_second),LOG_COLOUR_COMMAND_SUCCESS);
		}
		else{
			sdm("Subject doesn't have image system",LOG_COLOUR_COMMAND_ERROR);
			exit;
		}
	}
}
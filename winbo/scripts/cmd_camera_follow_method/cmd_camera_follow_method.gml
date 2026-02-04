/// @function cmd_camera_follow_method
/// @summary Change the camera follow smoothing method via console.
/// @param _subject       Command caller (unused).
/// @param _argument_list Arguments array: ["lerp"|"curve"].
function cmd_camera_follow_method(_subject,_argument_list){
	var _method;
	_method = _argument_list[| 0];
	
	switch(string_lower(_method)){
		case "lerp":
			_method = CameraFollowMethod.lerp_to_targ;
			
			sdm("Camera follow method set to lerp",LOG_COLOUR_COMMAND_SUCCESS);
		break;
		
		case "curve":
			_method = CameraFollowMethod.curve_to_targ;
			
			sdm("Camera follow method set to curve",LOG_COLOUR_COMMAND_SUCCESS);
		break;
		
		default:
			sdm("Argument is invalid, must be lerp / curve : " + _method,LOG_COLOUR_COMMAND_ERROR);
			exit;
		break;
	}
	
	with(o_camera){
		follow_method = _method;
	}
}
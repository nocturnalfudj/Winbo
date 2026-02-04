/// @function cmd_camera_state
/// @summary Change the active camera state via a console command.
/// @param _subject        Command subject instance
/// @param _argument_list  List containing the state name
function cmd_camera_state(_subject,_argument_list){
	var _state;
	_state = _argument_list[| 0];

	switch(string_lower(_state)){
		case "idle":
			_state = CameraState.idle;

			sdm("Camera state set to idle",LOG_COLOUR_COMMAND_SUCCESS);
		break;

		case "follow":
			_state = CameraState.follow;

			sdm("Camera state set to follow",LOG_COLOUR_COMMAND_SUCCESS);
		break;

		case "stationary":
			_state = CameraState.stationary;

			sdm("Camera state set to stationary",LOG_COLOUR_COMMAND_SUCCESS);
		break;

		case "move":
			_state = CameraState.move;

			sdm("Camera state set to move",LOG_COLOUR_COMMAND_SUCCESS);
		break;

		default:
			sdm("Argument is invalid, must be idle / follow / stationary / move : " + _state,LOG_COLOUR_COMMAND_ERROR);
			exit;
		break;
	}

	with(o_camera){
		state = _state;
	}
}
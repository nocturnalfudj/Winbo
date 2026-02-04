/// @function cmd_instance_object_camera_follow
/// @summary Console command to set the camera to follow a target instance.
/// @param _subject Instance that becomes the camera target.
/// @param _argument_list Ignored argument list.
function cmd_instance_object_camera_follow(_subject,_argument_list) {
	with(_subject){
		with(o_camera){
			follow_target_id = other.id;
			
			sdm("Camera set to follow instance " + string(id),LOG_COLOUR_COMMAND_SUCCESS);
		}
		exit;
	}
}
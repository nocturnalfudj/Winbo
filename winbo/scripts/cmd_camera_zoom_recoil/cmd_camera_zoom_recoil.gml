function cmd_camera_zoom_recoil(_subject,_argument_list){
	var _transform;
	_transform = _argument_list[| 0];
	
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

	with(o_camera){
		transform_value_recoil_no_curve(_transform);
		
		sdm("Camera zoom " + string(_transform) + " recoiled",LOG_COLOUR_COMMAND_SUCCESS);
	}
}
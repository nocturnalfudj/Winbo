/// @function cmd_settings_anti_aliasing
/// @summary Console command to change anti-aliasing levels.
/// @param _subject Unused command subject.
/// @param _argument_list List containing the AA level.
function cmd_settings_anti_aliasing(_subject,_argument_list){
	var _anti_aliasing_val;
	_anti_aliasing_val = _argument_list[| 0];
	
	if(string_is_real(_anti_aliasing_val)){
		switch(_anti_aliasing_val){
			case 0:
			case 2:
			case 4:
			case 8:
				with(o_camera){
					if(anti_aliasing_supported[_anti_aliasing_val]){
						anti_aliasing = _anti_aliasing_val;
						
						sdm("Anti Aliasing set to " + string(_anti_aliasing_val),LOG_COLOUR_COMMAND_SUCCESS);
						
						display_reset(anti_aliasing,vsync);
						
						camera_save();
					}
					else{
						sdm("Anti Aliasing Level not supported : " + _anti_aliasing_val,LOG_COLOUR_COMMAND_ERROR);
					}
				}
			break;
			
			default:
				sdm("Argument is invalid, must be 0, 2, 4, or 8 : " + _anti_aliasing_val,LOG_COLOUR_COMMAND_ERROR);
			break;
		}
	}
	else{
		sdm("Argument is invalid, must be 0, 2, 4, or 8 : " + _anti_aliasing_val,LOG_COLOUR_COMMAND_ERROR);
	}
}
/// @function cmd_settings_vsync
/// @summary Console command to toggle vertical sync.
/// @param _subject Unused command subject.
/// @param _argument_list List with a single on/off value.
function cmd_settings_vsync(_subject,_argument_list){
	var _val;
	_val = _argument_list[| 0];

	if((string_lower(_val) == "false") || (_val == "0")){
		with(o_camera){
			vsync = false;
			
			sdm("VSync disabled",LOG_COLOUR_COMMAND_SUCCESS);
			
			display_reset(anti_aliasing,vsync);
			
			camera_save();
			
			with(o_btn_vsync){
				button_toggle_set(false);
			}
		}
	}
	else if((string_lower(_val) == "true") || (_val == "1")){
		with(o_camera){
			vsync = true;
			
			sdm("VSync enabled",LOG_COLOUR_COMMAND_SUCCESS);
			
			display_reset(anti_aliasing,vsync);
			
			camera_save();
			
			with(o_btn_vsync){
				button_toggle_set(true);
			}
		}
	}
	else
		sdm("Argument is invalid, must be true/false or 1/0 : " + _val,LOG_COLOUR_COMMAND_ERROR);
}
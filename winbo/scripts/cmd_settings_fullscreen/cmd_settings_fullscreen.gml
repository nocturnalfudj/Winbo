/// @function cmd_settings_fullscreen
/// @summary Toggle fullscreen mode from the console.
/// @param _subject Console subject (unused).
/// @param _argument_list Arguments: [true/false].
/// @returns {void} No return value.
function cmd_settings_fullscreen(_subject,_argument_list){
	var _val;
	_val = _argument_list[| 0];

	if((string_lower(_val) == "false") || (_val == "0")){
		with(o_camera){
			fullscreen = false;
			
			sdm("Fullscreen enabled",LOG_COLOUR_COMMAND_SUCCESS);
			
			window_set_fullscreen(fullscreen);
			
			camera_save();
			
			with(o_btn_full_screen){
				button_toggle_set(false);
			}
		}
	}
	else if((string_lower(_val) == "true") || (_val == "1")){
		with(o_camera){
			fullscreen = true;
			
			sdm("Fullscreen disabled",LOG_COLOUR_COMMAND_SUCCESS);
			
			window_set_fullscreen(fullscreen);
			camera_save();
			
			with(o_btn_full_screen){
				button_toggle_set(true);
			}
		}
	}
	else
		sdm("Argument is invalid, must be true/false or 1/0 : " + _val,LOG_COLOUR_COMMAND_ERROR);
}
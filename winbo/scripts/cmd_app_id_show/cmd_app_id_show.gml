/// @function cmd_app_id_show
/// @summary Toggle ID debug display via the console.
/// @param _subject       Command caller (unused).
/// @param _argument_list List containing a single mode string.
function cmd_app_id_show(_subject,_argument_list) {
	var _val;
	_val = _argument_list[| 0];



	if((string_lower(_val) == "false") || (_val == "0")){
		id_show = IDShow.off;
		
		sdm("ID Show disabled",LOG_COLOUR_COMMAND_SUCCESS);
	}
	else if((string_lower(_val) == "all") || (_val == "1")){
		id_show = IDShow.everything;
		
		sdm("ID Show everything",LOG_COLOUR_COMMAND_SUCCESS);
	}
	else if((string_lower(_val) == "mouse") || (_val == "2")){
		id_show = IDShow.mouse;
		sdm("ID Show mouse",LOG_COLOUR_COMMAND_SUCCESS);
	}
	else{
		sdm("Argument is invalid, must be false/all/mouse or 0/1/2 : " + _val,LOG_COLOUR_COMMAND_ERROR);
	}
}
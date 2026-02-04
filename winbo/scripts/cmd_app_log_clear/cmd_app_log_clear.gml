/// @function cmd_app_log_clear
/// @summary Console command that removes all lines from the log.
/// @param _subject Unused command subject.
/// @param _argument_list Ignored argument list.
function cmd_app_log_clear(_subject,_argument_list) {
	ds_list_clear(log);
	ds_list_clear(log_colour);

	with(o_console_text_field){
		sdm("Log cleared",LOG_COLOUR_COMMAND_SUCCESS);
		
		ds_list_clear(command_list);
		command_list_pos = 0;
	}
}
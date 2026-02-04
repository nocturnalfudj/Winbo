/// @function cmd_app_close
/// @summary Console command to exit the application.
function cmd_app_close() {
	sdm("App closed",LOG_COLOUR_COMMAND_SUCCESS);
	game_end();
}
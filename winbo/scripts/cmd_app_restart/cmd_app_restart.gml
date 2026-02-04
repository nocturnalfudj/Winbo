/// @function cmd_app_restart
/// @summary Restart the game from the console.
function cmd_app_restart() {
	sdm("App restarted",LOG_COLOUR_COMMAND_SUCCESS);
	game_restart();
}
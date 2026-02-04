/// @function cmd_game_level_stats_reset()
function cmd_game_level_stats_reset(){
	level_stat_reset_all();
	sdm("All level stats reset to 0", LOG_COLOUR_COMMAND_SUCCESS);
}

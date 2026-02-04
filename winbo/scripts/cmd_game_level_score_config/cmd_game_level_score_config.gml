/// @function cmd_game_level_score_config()
function cmd_game_level_score_config(){
	var _config = o_director.level_score_config;
	
	sdm("=== Level Score Configuration ===", LOG_COLOUR_COMMAND_SUCCESS);
	sdm("Points per Orb: " + string(_config.points_per_orb), c_white);
	sdm("Points per Life: " + string(_config.points_per_life), c_white);
	sdm("Points per Talisman: " + string(_config.points_per_talisman), c_white);
	sdm("Points per Melee Enemy: " + string(_config.points_per_melee_enemy), c_white);
	sdm("Points per Ranged Enemy: " + string(_config.points_per_ranged_enemy), c_white);
	sdm("Points per Flying Enemy: " + string(_config.points_per_flying_enemy), c_white);
	sdm("Time Penalty Start: " + string(_config.time_penalty_start_seconds) + "s", c_white);
	sdm("Time Penalty Per Second: " + string(_config.time_penalty_per_second), c_white);
}

/// @function cmd_game_level_stats()
function cmd_game_level_stats(){
	var _output = "=== Level Stats ===";
	sdm(_output, LOG_COLOUR_COMMAND_SUCCESS);
	sdm("Orbs: " + string(level_stat_get(LevelStat.orbs_collected)), c_white);
	sdm("Lives: " + string(level_stat_get(LevelStat.lives_collected)), c_white);
	sdm("Talismans: " + string(level_stat_get(LevelStat.talismans_collected)), c_white);
	sdm("Melee Enemies: " + string(level_stat_get(LevelStat.enemies_defeated_melee)), c_white);
	sdm("Ranged Enemies: " + string(level_stat_get(LevelStat.enemies_defeated_ranged)), c_white);
	sdm("Flying Enemies: " + string(level_stat_get(LevelStat.enemies_defeated_flying)), c_white);
	sdm("Hits Taken: " + string(level_stat_get(LevelStat.hits_taken)), c_white);
	sdm("Deaths: " + string(level_stat_get(LevelStat.deaths)), c_white);
	sdm("Time: " + string(o_director.level_timer) + "s", c_white);
}

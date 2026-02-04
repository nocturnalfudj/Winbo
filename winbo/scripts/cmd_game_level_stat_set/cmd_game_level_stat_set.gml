/// @function cmd_game_level_stat_set(stat_name, value)
function cmd_game_level_stat_set(_stat_name, _value){
	// Convert stat name string to enum
	var _stat = -1;
	switch(_stat_name){
		case "orbs_collected": _stat = LevelStat.orbs_collected; break;
		case "lives_collected": _stat = LevelStat.lives_collected; break;
		case "talismans_collected": _stat = LevelStat.talismans_collected; break;
		case "enemies_defeated_melee": _stat = LevelStat.enemies_defeated_melee; break;
		case "enemies_defeated_ranged": _stat = LevelStat.enemies_defeated_ranged; break;
		case "enemies_defeated_flying": _stat = LevelStat.enemies_defeated_flying; break;
		case "hits_taken": _stat = LevelStat.hits_taken; break;
		case "deaths": _stat = LevelStat.deaths; break;
	}
	
	if(_stat == -1){
		sdm("Invalid stat name: " + _stat_name, LOG_COLOUR_COMMAND_ERROR);
		return;
	}
	
	level_stat_set(_stat, real(_value));
	sdm("Set " + _stat_name + " to " + string(_value), LOG_COLOUR_COMMAND_SUCCESS);
}

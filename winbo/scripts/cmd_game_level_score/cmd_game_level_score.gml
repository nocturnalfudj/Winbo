/// @function cmd_game_level_score()
function cmd_game_level_score(){
	var _score = level_score_calculate();
	
	sdm("=== Level Score Breakdown ===", LOG_COLOUR_COMMAND_SUCCESS);
	sdm("Collectibles: " + string(_score.points_collectibles) + " pts (" + 
		string(_score.orbs_collected) + " orbs, " + 
		string(_score.lives_collected) + " lives, " + 
		string(_score.talismans_collected) + " talismans)", c_white);
	sdm("Enemies: " + string(_score.points_enemies) + " pts (" + 
		string(_score.enemies_defeated_total) + " total)", c_white);
	sdm("Damage Bonus: " + string(_score.points_damage) + " pts (" + 
		string(_score.hits_taken) + " hits)", c_white);
	sdm("Death Bonus: " + string(_score.points_deaths) + " pts (" + 
		string(_score.deaths) + " deaths)", c_white);
	sdm("Time Penalty: " + string(_score.points_time) + " pts (" + 
		string(_score.time_seconds) + "s)", c_white);
	sdm("=== TOTAL SCORE: " + string(_score.total_score) + " ===", LOG_COLOUR_COMMAND_SUCCESS);
}

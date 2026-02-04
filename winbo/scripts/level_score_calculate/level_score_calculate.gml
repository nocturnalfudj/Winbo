/// @function level_score_calculate()
/// @return {struct} Score breakdown and total
function level_score_calculate(){
	var _config = o_director.level_score_config;
	var _result = {};
	
	// Collectibles
	_result.orbs_collected = level_stat_get(LevelStat.orbs_collected);
	_result.lives_collected = level_stat_get(LevelStat.lives_collected);
	_result.talismans_collected = level_stat_get(LevelStat.talismans_collected);
	_result.points_collectibles = 
		(_result.orbs_collected * _config.points_per_orb) +
		(_result.lives_collected * _config.points_per_life) +
		(_result.talismans_collected * _config.points_per_talisman);
	
	// Enemies
	var _melee = level_stat_get(LevelStat.enemies_defeated_melee);
	var _ranged = level_stat_get(LevelStat.enemies_defeated_ranged);
	var _flying = level_stat_get(LevelStat.enemies_defeated_flying);
	_result.enemies_defeated_total = _melee + _ranged + _flying;
	_result.points_enemies = 
		(_melee * _config.points_per_melee_enemy) +
		(_ranged * _config.points_per_ranged_enemy) +
		(_flying * _config.points_per_flying_enemy);
	
	// Damage taken (threshold-based)
	var _hits = level_stat_get(LevelStat.hits_taken);
	_result.hits_taken = _hits;
	_result.points_damage = 0;
	for(var _i = 0; _i < array_length(_config.damage_thresholds); _i++){
		var _threshold = _config.damage_thresholds[_i];
		if(_hits <= _threshold.hits || _i == array_length(_config.damage_thresholds) - 1){
			_result.points_damage = _threshold.points;
			break;
		}
	}
	
	// Deaths (threshold-based)
	var _deaths = level_stat_get(LevelStat.deaths);
	_result.deaths = _deaths;
	_result.points_deaths = 0;
	for(var _i = 0; _i < array_length(_config.death_thresholds); _i++){
		var _threshold = _config.death_thresholds[_i];
		if(_deaths <= _threshold.deaths || _i == array_length(_config.death_thresholds) - 1){
			_result.points_deaths = _threshold.points;
			break;
		}
	}
	
	// Time penalty
	var _time = o_director.level_timer;
	_result.time_seconds = _time;
	_result.points_time = 0;
	if(_time > _config.time_penalty_start_seconds){
		var _overtime = _time - _config.time_penalty_start_seconds;
		_result.points_time = -floor(_overtime * _config.time_penalty_per_second);
	}
	
	// Total score
	_result.total_score = 
		_result.points_collectibles +
		_result.points_enemies +
		_result.points_damage +
		_result.points_deaths +
		_result.points_time;
	
	return _result;
}

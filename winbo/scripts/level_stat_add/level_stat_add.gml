/// @function level_stat_add(stat, amount)
/// @param {LevelStat} stat - The stat to modify
/// @param {real} amount - Amount to add (default 1)
function level_stat_add(_stat, _amount = 1){
	with(o_director){
		level_stats[_stat] += _amount;
	}
}

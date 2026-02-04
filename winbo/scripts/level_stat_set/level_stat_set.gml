/// @function level_stat_set(stat, value)
/// @param {LevelStat} stat - The stat to set
/// @param {real} value - Value to set
function level_stat_set(_stat, _value){
	with(o_director){
		level_stats[_stat] = _value;
	}
}

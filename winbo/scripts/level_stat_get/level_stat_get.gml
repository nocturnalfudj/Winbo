/// @function level_stat_get(stat)
/// @param {LevelStat} stat - The stat to retrieve
/// @return {real} The stat value
function level_stat_get(_stat){
	return o_director.level_stats[_stat];
}

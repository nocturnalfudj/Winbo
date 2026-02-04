/// @function level_stat_reset_all()
function level_stat_reset_all(){
	with(o_director){
		for(var _i = 0; _i < LevelStat.SIZE; _i++){
			level_stats[_i] = 0;
		}
	}
}

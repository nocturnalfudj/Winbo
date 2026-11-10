function pickup_collect_talisman(){
	with(o_director){
		talisman_found[other.talisman_id] = true;
	}
	
	//Track talisman collection
	level_stat_add(LevelStat.talismans_collected);
	
	// Freeze the frame and play the "Talisman Got" sequence over it.
	instance_create_layer(0, 0, "lyr_cutscene_front", o_talisman_got, {talisman_id: talisman_id});
	game_state_set_target(GameState.cutscene);
}
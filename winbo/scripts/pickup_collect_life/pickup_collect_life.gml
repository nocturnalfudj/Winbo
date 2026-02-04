function pickup_collect_life(){
	with(o_director){
		resource[Resource.winbo_lives][Team.player] += other.life_value;
	}
	
	//Track life collection
	level_stat_add(LevelStat.lives_collected);
	
	with(instance_create_layer(x,y,"lyr_pfx_foreground",o_txtPstr_life)){
		text_string = string(other.life_value);
	}
	
	//Camera Shake
	camera_shake_add(0.1,250,10,5,false,false,false,1,,false,100,);
}
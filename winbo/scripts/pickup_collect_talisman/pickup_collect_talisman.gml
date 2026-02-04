function pickup_collect_talisman(){
	//Abort if No Talisman ID Set
	if(talisman_id == noone)
		exit;
	
	with(o_director){
		talisman_found[other.talisman_id] = true;
	}
	
	//Track talisman collection
	level_stat_add(LevelStat.talismans_collected);
	
	instance_create_layer(x,y,"lyr_pfx_foreground",o_txtPstr_talisman);
	
	//Camera Shake
	camera_shake_add(0.1,250,10,5,false,false,false,1,,false,100,);
}
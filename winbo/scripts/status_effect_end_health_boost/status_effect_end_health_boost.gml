function status_effect_end_health_boost(){
	//Reset Back to Default
	hp_set_max(hp_max_default);
	
	//Update HP To Match Previous Percentage
	hp = hp_percent * hp_max;
	
	//HP Bar Health Boost Scale
	info_bar_hp_health_boost_scale_target = 1;
}
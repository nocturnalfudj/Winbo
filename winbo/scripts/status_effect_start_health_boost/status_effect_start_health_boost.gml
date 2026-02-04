function status_effect_start_health_boost(){
	var _new_max,_new_max_difference;
	_new_max = hp_max_default * 2;
	_new_max_difference = _new_max - hp;
	
	//Increase HP Max
	hp_set_max(hp_max_default*2,false);
	
	//Give Regen to New Max
	//hp_regen_remaining += _new_max_difference;
	
	//Update HP To Match Previous Percentage
	hp = hp_percent * _new_max;
	
	//HP Bar Health Boost Scale
	info_bar_hp_health_boost_scale_target = 1.5;
}
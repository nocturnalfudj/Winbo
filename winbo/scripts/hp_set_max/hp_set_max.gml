function hp_set_max(_new_max_value,_update_default){
	//Update Max Value
	hp_max = _new_max_value;
	
	//Default to Update Default
	if(_update_default == undefined)
		_update_default = true;
		
	//Update Default
	if(_update_default)
		hp_max_default = _new_max_value;
		
	//Keep HP at or below HP Max
	if(!hp_overhealth_enable)
		hp = min(hp_max,hp);
		
	//Update Percent
	hp_percent = hp/hp_max;
}
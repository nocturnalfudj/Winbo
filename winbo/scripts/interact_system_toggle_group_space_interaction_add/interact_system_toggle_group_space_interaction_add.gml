function interact_system_toggle_group_space_interaction_add(_interact_toggle_group){
	var _self;
	_self = self;
	
	
	//Add Self it List in Director
	with(o_director){
		ds_list_add(interact_toggle_group_space_interaction_list[_interact_toggle_group],_self);
	}
}
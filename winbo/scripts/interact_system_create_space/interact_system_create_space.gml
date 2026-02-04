function interact_system_create_space(_interaction_count){
	//New Interact Space
	var _new_space;
	_new_space = new InteractSpace(_interaction_count);
	
	interact_space[interact_space_count] = _new_space
	
	//Increase Space Count
	interact_space_count++;
	
	return _new_space;
}
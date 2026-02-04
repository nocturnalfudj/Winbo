function interact_system_create_space_interaction(_space,_user_id){
	//New Interaction
	var _new_interaction;
	_new_interaction =  new InteractSpaceInteraction(_space);
	interaction[_user_id][interaction_count] = _new_interaction;
	
	//Increase Space Interaction Count
	interaction_count++;
	
	return _new_interaction;
}
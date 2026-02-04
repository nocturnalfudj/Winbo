function interact_system_user_in_position_update(_space){
	//Store Reference to User In Position Array
	var _user_in_position_array,_user_x_array,_user_y_array;
	_user_in_position_array = user_in_position;
	_user_x_array = user_x;
	_user_y_array = user_y;
	
	//Check Players if Self is Nearest Interaction
	with(o_player){
		if(user_id == noone)
			continue;
		
		if(interact_system_interactor_nearest_interact_space == _space){
			_user_in_position_array[@ user_id] = true;
			
			_user_x_array[@ user_id] = x;
			_user_y_array[@ user_id] = y;
		}
		else{
			_user_in_position_array[@ user_id] = false;
		}
	}
}
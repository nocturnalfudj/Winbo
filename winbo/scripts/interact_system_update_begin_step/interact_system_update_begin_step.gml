function interact_system_update_begin_step(){
	//Ignore if Interact Disabled
	if(interact_enable == false)
		exit;
		
	//Store Object Position
	var _object_x,_object_y;
	_object_x = x;
	_object_y = y;
		
	//Go Through All Spaces
	var _space;
	var _user_in_position_array;
	var _x,_y,_x1,_y1,_x2,_y2,_range,_player_distance_to_space
	for(var _i=0;_i<interact_space_count;_i++){
		_space = interact_space[_i];
		with(_space){
			//Get Array
			_user_in_position_array = user_in_position;
			
			switch(user_position){
				case InteractUserPosition.specifc:
					_x = _object_x + user_position_x;
					_y = _object_y + user_position_y;
					with(o_player){
						//Interactor Must Be Enabled
						if(!interact_system_interactor_enable)
							continue;
					
						//Check if Player is in Position
						if((x == _x) && (y == _y)){
							//Update Player's Nearest Interaction
							interact_system_interactor_nearest_interact_space_distance = 0;
							interact_system_interactor_nearest_interact_space = _space;
						}
					}
				break;
				
				case InteractUserPosition.box:
					_x1 = _object_x + user_position_x;
					_y2 = _object_y + user_position_y;
					_x2 = _object_x + user_position_x2;
					_y2 = _object_y + user_position_y2;
			
					_x = (_x1 + _x2)/2;
					_y = (_y1 + _y2)/2;
					with(o_player){
						//Interactor Must Be Enabled
						if(!interact_system_interactor_enable)
							continue;
					
						//Get Distance From Player to Interact Object
						_player_distance_to_space = point_distance(x,y,_x,_y);
				
						//Check if Nearest Interaction
						if((_player_distance_to_space < interact_system_interactor_nearest_interact_space_distance) || (interact_system_interactor_nearest_interact_space_distance == -1)){
							//Check if Player is in Position
							if(point_in_rectangle(x,y,_x1,_y1,_x2,_y2)){
								//Update Player's Nearest Interaction
								interact_system_interactor_nearest_interact_space_distance = _player_distance_to_space;
								interact_system_interactor_nearest_interact_space = _space;
							}
						}
					}
				break;
				
				case InteractUserPosition.range:
					_x = _object_x;
					_y = _object_y;
					_range = user_position_range;
					with(o_player){
						//Interactor Must Be Enabled
						if(!interact_system_interactor_enable)
							continue;
					
						//Get Distance From Player to Interact Object
						_player_distance_to_space = point_distance(x,y,_x,_y);
				
						//Check if Nearest Interaction
						if((_player_distance_to_space <= interact_system_interactor_nearest_interact_space_distance) || (interact_system_interactor_nearest_interact_space_distance == -1)){
							//Check if Player is in Position
							if(_player_distance_to_space <= _range){
						
								//Update Player's Nearest Interaction
								interact_system_interactor_nearest_interact_space_distance = _player_distance_to_space;
								interact_system_interactor_nearest_interact_space = _space;
							}
						}
					}
				break;
			}
		}
	}
}
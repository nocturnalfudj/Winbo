function spawner_state_spawn(){
	var _spawn_object;
	_spawn_object = spawn_object;
		
	#region Determine Spawn Object
		if(_spawn_object == noone){
			//Weighted Roll from Array
			if(spawn_object_weight_array != noone){
				//Roll
				var _spawn_roll;
				_spawn_roll = roll_weight_from_array(spawn_object_weight_array);
			
				//Roll Was Valid
				if((_spawn_roll != -1) && (spawn_object_array != noone)){
					//Get Reference to Object
					_spawn_object = spawn_object_array[_spawn_roll];
				}
			}
		}
	#endregion
	
	#region Spawn Object is Valid
		if(_spawn_object != noone){
			repeat(spawn_count){
				//Pick Random Spawn Spot Within Area
				var _x,_y,_spawn_spot_found;
				_x = x + random_range(-spawn_dist_x,spawn_dist_x);
				_y = y + random_range(-spawn_dist_y,spawn_dist_y);
				_spawn_spot_found = true;
				
				#region Attempt to Make Spawn Point Off Camera
					if(spawn_off_camera){
						_spawn_spot_found = false;
						
						var _camera_x1,_camera_x2,_camera_y1,_camera_y2;
						with(o_camera){
							_camera_x1 = start_x;
							_camera_y1 = start_y;
	
							_camera_x2 = end_x;
							_camera_y2 = end_y;
						}
						
						var _buff_w,_buff_h;
						_buff_w = 500;
						_buff_h = 500;
						_buff_w = _buff_w/2;
						_buff_h = _buff_h/2;
	
						_camera_x1 -= _buff_w;
						_camera_x2 += _buff_w;
	
						_camera_y1 -= _buff_h;
						_camera_y2 += _buff_h;
			
						for(var _i=0;_i<100;_i++){
							if(!point_in_rectangle(_x,_y,_camera_x1,_camera_y1,_camera_x2,_camera_y2)){
								_spawn_spot_found = true;
								break;
							}
							else{
								_x = x + random_range(-spawn_dist_x,spawn_dist_x);
								_y = y + random_range(-spawn_dist_y,spawn_dist_y);
							}
						}
						
						camera_visible_check()
					}
				#endregion

				#region Attempt to Make Spawn Point Not Near Player
					//If Already Spawning Off Camera Ignore this
					if((!spawn_off_camera) && (spawn_avoid_player)){
						_spawn_spot_found = false;
			
						for(var _i=0;_i<100;_i++){
							if(!collision_circle(_x,_y,3000,o_player,false,false)){
								_spawn_spot_found = true;
								break;
							}
							else{
								_x = x + random_range(-spawn_dist_x,spawn_dist_x);
								_y = y + random_range(-spawn_dist_y,spawn_dist_y);
							}
						}
					}
					else{
			
					}
				#endregion

				//Spawn Object
				if(_spawn_spot_found)
					instance_create_layer(_x,_y,spawn_layer,_spawn_object);
			}
		}
	#endregion

	//Back to Idle State
	state = SpawnerState.idle;
}
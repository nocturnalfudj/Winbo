// Inherit the parent event
event_inherited();

//Game State Switch
switch(global.game_state){
	case GameState.play:
		switch(moving_platform_state){
			case MovingPlatformState.move:
				#region Update Position
					var _path_point_current_data;
					_path_point_current_data = path_point[path_point_current];
					
					if(path_direction == 1){
						path_x = script_execute(_path_point_current_data.forward.ease_x,path_point_start_x,_path_point_current_data.x,false,path_time,_path_point_current_data.forward.time);
						path_y = script_execute(_path_point_current_data.forward.ease_y,path_point_start_y,_path_point_current_data.y,false,path_time,_path_point_current_data.forward.time);
					}
					else{
						path_x = script_execute(_path_point_current_data.backward.ease_x,path_point_start_x,_path_point_current_data.x,false,path_time,_path_point_current_data.backward.time);
						path_y = script_execute(_path_point_current_data.backward.ease_y,path_point_start_y,_path_point_current_data.y,false,path_time,_path_point_current_data.backward.time);
					}
				#endregion
			
				//Increase Path Time
				path_time += global.delta_time_factor_scaled;
			
				#region Path Point Progression
					var _path_current_time;
					if(path_direction == 1){
						_path_current_time = path_point[path_point_current].forward.time;
					}
					else{
						_path_current_time = path_point[path_point_current].backward.time;
					}
				
					//Completed Transition to Current Point
					if(path_time >= _path_current_time){
						//Set Position
						path_x = _path_point_current_data.x;
						path_y = _path_point_current_data.y;
						path_point_start_x = path_x;
						path_point_start_y = path_y;
						
						//Increase Current Point
						path_point_current += path_direction;
						
						//Reset Path Time
						path_time = 0;
					
						//Reached the Final Point
						if(((path_direction == 1) && (path_point_current >= path_point_total)) || ((path_direction == -1) && (path_point_current <= -1))){
							//Loops
							if(path_loop){
								//If Direction Should Swap
								if(path_loop_swap_direction){
									//Swap Direction
									path_direction *= -1;
									
									//Go 1 Point Back
									path_point_current += path_direction * 2;	//It progressed 1 before, so go back 1 and then back 1 again
								}
								else{
									//Go Back to Start
									path_point_current = 0;
								}
							}
							else{
								moving_platform_state = MovingPlatformState.stop;
							}
						}
					}
				#endregion
				
				//Update Real Position
				x = start_x + path_x;
				y = start_y + path_y;
			break;
			
			case MovingPlatformState.stop:
				//Nothing
			break;
		}
	break;
}
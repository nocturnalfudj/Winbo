/// @function actor_pathfind_and_move_to_target
/// @summary Recalculate a path and move toward the specified target.
/// @param target_data Instance containing pathfinding target info.
function actor_pathfind_and_move_to_target(_target_data){
	if(global.tick_now == path_finding_tick){
		var _target_x,_target_y;
		with(_target_data){
			//Set Target Position
			_target_x = x;
			_target_y = y;
		}
		
		if((!_target_data.is_within_trigger_distance()) || (collision_line(x,y,_target_x,_target_y,o_solid,false,true) != noone)){
			path_finding_path_found = mp_grid_path(global.path_finding_grid,path_finding_path,x,y,_target_x,_target_y,true);
		
			var _next_x,_next_y;
			_next_x = path_get_point_x(path_finding_path,1);
			_next_y = path_get_point_y(path_finding_path,1);
					
			input_move_direction = point_direction(x,y,_next_x,_next_y);
		}
		else{
			path_finding_path_found = false;
		}
		
	}
	
	if(path_finding_path_found){
		input_move_magnitude = 1;
		
		// Check for crossing the 0/360 threshold
		if (abs(input_aim_direction - input_move_direction) > 180)
		{
			if (input_aim_direction > input_move_direction)
				input_aim_direction -= 360;
			else
				input_aim_direction += 360;
		}
		
		input_aim_direction = lerp(input_aim_direction,input_move_direction,0.2);
	}
	else{
		input_move_magnitude = 0;
		
		// Check for crossing the 0/360 threshold
		if (abs(input_aim_direction - _target_data.direction) > 180)
		{
			if (input_aim_direction > _target_data.direction)
				input_aim_direction -= 360;
			else
				input_aim_direction += 360;
		}
		
		input_aim_direction = lerp(input_aim_direction,_target_data.direction,0.2);
	}
}
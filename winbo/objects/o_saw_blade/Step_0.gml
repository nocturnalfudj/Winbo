event_inherited();

if(global.game_state == GameState.play){
	image_angle += (360 * 5 / SECOND) * global.delta_time_factor_scaled;

	if(saw_path_point_total > 1){
		var _path_point_current_data = saw_path_point[saw_path_point_current];

		if(saw_path_direction == 1){
			saw_path_x = script_execute(_path_point_current_data.forward.ease_x, saw_path_point_start_x, _path_point_current_data.x, false, saw_path_time, _path_point_current_data.forward.time);
			saw_path_y = script_execute(_path_point_current_data.forward.ease_y, saw_path_point_start_y, _path_point_current_data.y, false, saw_path_time, _path_point_current_data.forward.time);
		}
		else{
			saw_path_x = script_execute(_path_point_current_data.backward.ease_x, saw_path_point_start_x, _path_point_current_data.x, false, saw_path_time, _path_point_current_data.backward.time);
			saw_path_y = script_execute(_path_point_current_data.backward.ease_y, saw_path_point_start_y, _path_point_current_data.y, false, saw_path_time, _path_point_current_data.backward.time);
		}

		saw_path_time += global.delta_time_factor_scaled;

		var _path_current_time;
		if(saw_path_direction == 1){
			_path_current_time = saw_path_point[saw_path_point_current].forward.time;
		}
		else{
			_path_current_time = saw_path_point[saw_path_point_current].backward.time;
		}

		if(saw_path_time >= _path_current_time){
			saw_path_x = _path_point_current_data.x;
			saw_path_y = _path_point_current_data.y;
			saw_path_point_start_x = saw_path_x;
			saw_path_point_start_y = saw_path_y;
			saw_path_point_current += saw_path_direction;
			saw_path_time = 0;

			if(((saw_path_direction == 1) && (saw_path_point_current >= saw_path_point_total)) || ((saw_path_direction == -1) && (saw_path_point_current <= -1))){
				if(saw_path_loop){
					if(saw_path_loop_swap_direction){
						saw_path_direction *= -1;
						saw_path_point_current += saw_path_direction * 2;
					}
					else{
						saw_path_point_current = 0;
					}
				}
			}
		}

		x = saw_start_x + saw_path_x;
		y = saw_start_y + saw_path_y;
	}
	else{
		x = saw_start_x;
		y = saw_start_y;
	}
}

image_system_update();

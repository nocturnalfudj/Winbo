/// @description Space Ranger sheathe state - returns to patrol origin after deaggro
function enemy_space_ranger_state_sheathe(){
	// Enable face flip for idle sprite (left-facing, needs flip system)
	face_horizontal_draw_enable = true;

	// Update Health
	character_health();

	// Use idle sprite (Space Ranger doesn't have sheathe animation)
	if(sprite_current != sprite_idle){
		image_system_setup(sprite_idle, ANIMATION_FPS_DEFAULT * animation_fps_multiplier, true, true, 0, IMAGE_LOOP_FULL);
	}

	// Calculate distance to patrol origin
	var _dist_to_origin = point_distance(x, y, patrol_origin_x, patrol_origin_y);
	var _arrival_threshold = 32; // Pixels - close enough to consider "arrived"

	if(_dist_to_origin > _arrival_threshold){
		// Use pathfinding to return to patrol origin (navigates around obstacles)
		var _path_found = mp_grid_path(global.path_finding_grid, path_finding_path, x, y, patrol_origin_x, patrol_origin_y, true);

		if(_path_found){
			// Follow the pathfinding route
			var _next_x = path_get_point_x(path_finding_path, 1);
			var _next_y = path_get_point_y(path_finding_path, 1);
			input_move_direction = point_direction(x, y, _next_x, _next_y);
			input_move_magnitude = 1;
		}
		else{
			// Fallback to direct flight if no path found
			input_move_direction = point_direction(x, y, patrol_origin_x, patrol_origin_y);
			input_move_magnitude = 1;
		}

		input_aim_direction = input_move_direction;

		// Apply movement acceleration
		acceleration.AddMagnitudeDirection(INPUT_MOVE_ACCELERATION * input_move_magnitude, input_move_direction);
	}
	else{
		// Arrived at origin - return to non-hostile patrol state
		is_hostile = false;
		hostility_detection_enable = true;
		deaggro_timer = 0;
		attack_countdown = 0;

		// Reset movement speed to patrol speed
		movement_input_move_acceleration_factor_set(1.0);

		// Transition to move state (patrol)
		state = EnemyState.move;
	}

	#region Out of Room
		if((x < 0) || (x > room_width) || (y < 0) || (y > room_height)){
			character_kill();
		}
	#endregion
}

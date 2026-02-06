function enemy_space_ranger_state_move(){
	// Lerp attack rotation back to 0 instead of snapping
	if (attack_rotation_active) {
		var _diff = angle_difference(0, attack_locked_draw_angle);
		if (abs(_diff) < 1) {
			attack_locked_draw_angle = 0;
			attack_rotation_active = false;
		} else {
			attack_locked_draw_angle += _diff * attack_rotation_lerp_speed;
		}
	}

	// Debug: periodic animation state logging
	if (!variable_instance_exists(id, "_move_log_timer")) _move_log_timer = 0;
	_move_log_timer++;
	if (_move_log_timer >= 30) { // Log every 30 frames (~0.5 sec)
		_move_log_timer = 0;
		if (image != noone) {
			__mcp_log("[MOVE] frame=" + string(sprite_current_frame) + " pos=" + string(image.position) + " loop=" + string(image.loop_start) + "-" + string(image.loop_end));
		}
	}

	// Track if we were hostile last frame (for speed boost on first aggro)
	var _was_hostile = is_hostile;

	// Backup path movement enable flag and disable it when hostile
	// (Base function's patrol path runs unconditionally when movement_path_enable = true)
	var _path_enable_backup = movement_path_enable;
	if(is_hostile){
		movement_path_enable = false;
	}

	// Call base move state - handles detection, combat triggering, and patrol path
	// (base deaggro is disabled for Space Ranger - we use custom 2D deaggro below)
	enemy_state_move();

	// Restore path movement flag
	movement_path_enable = _path_enable_backup;

	// If parent transitioned to a different state (e.g., attack_telegraph), exit early
	// and re-enable face flip for the new state's sprites
	if(state != EnemyState.move){
		face_horizontal_draw_enable = true;

		// If transitioning to attack_telegraph, initialize aim values BEFORE the first draw
		// to prevent 1-frame glitch where aim_angle hasn't been calculated yet
		if(state == EnemyState.attack_telegraph){
			target_update(TargetType.attack);
			if(target[TargetType.attack] != noone){
				aim_angle = point_direction(x, y, target[TargetType.attack].x, target[TargetType.attack].y);

				// Set face_horizontal based on target position
				if(target[TargetType.attack].x > x){
					face_horizontal = 1;
				}
				else{
					face_horizontal = -1;
				}
			}
		}

		return;
	}

	// Speed boost when first becoming hostile
	if(is_hostile && !_was_hostile){
		movement_input_move_acceleration_factor_set(3.0);
	}

	// Override hostile movement: flying enemies need 2D movement, not X-axis following
	// (Base function's hostile movement is designed for grounded enemies)
	if(is_hostile){
		target_update(TargetType.attack);
		if(target[TargetType.attack] != noone){
			// Try pathfinding first
			actor_pathfind_and_move_to_target(target[TargetType.attack]);

			// If pathfinding failed (no path found), fall back to direct flight
			// Flying enemies can move directly toward player without obstacles
			if(!path_finding_path_found){
				input_move_direction = point_direction(x, y, target[TargetType.attack].x, target[TargetType.attack].y);
				input_move_magnitude = 1;
			}

			// Apply acceleration based on movement input
			acceleration.AddMagnitudeDirection(INPUT_MOVE_ACCELERATION * input_move_magnitude, input_move_direction);
		}
	}

	#region Movement Sprite Selection
		// Update movement sprite based on direction RELATIVE to facing
		// Only update when actually moving (has input or velocity)
		if (input_move_magnitude > 0 || abs(velocity.x) > 0.05 || abs(velocity.y) > 0.05) {
			// Normalize angle to 0-360 range
			var _move_angle = input_move_direction mod 360;
			if (_move_angle < 0) {
				_move_angle += 360;
			}

			// FIRST: Determine face_horizontal based on target (hostile) or movement (patrol)
			if (is_hostile && target[TargetType.attack] != noone) {
				// When chasing, always face the player
				if (target[TargetType.attack].x > x) {
					face_horizontal = 1;   // Player is to the right, face right
				}
				else {
					face_horizontal = -1;  // Player is to the left, face left
				}
			}
			else {
				// Patrol mode - face movement direction
				if (_move_angle > 90 && _move_angle < 270) {
					face_horizontal = -1;  // Left-ish movement, face left
				}
				else {
					face_horizontal = 1;   // Right-ish movement, face right
				}
			}

			// THEN: Determine movement direction RELATIVE to facing
			// Forward = moving toward where facing, Backward = moving away
			var _moving_forward = false;
			var _moving_backward = false;
			var _moving_up = false;
			var _moving_down = false;

			// Check forward/backward (relative to facing direction)
			if (face_horizontal == 1) {
				// Facing right: right-ish movement = forward, left-ish = backward
				if (_move_angle < 60 || _move_angle > 300) {
					_moving_forward = true;
				}
				else if (_move_angle > 120 && _move_angle < 240) {
					_moving_backward = true;
				}
			}
			else {
				// Facing left: left-ish movement = forward, right-ish = backward
				if (_move_angle > 120 && _move_angle < 240) {
					_moving_forward = true;
				}
				else if (_move_angle < 60 || _move_angle > 300) {
					_moving_backward = true;
				}
			}

			// Check up/down (absolute world direction)
			if (_move_angle > 30 && _move_angle < 150) {
				_moving_up = true;
			}
			else if (_move_angle > 210 && _move_angle < 330) {
				_moving_down = true;
			}

			// Select sprite based on relative movement components
			var _target_sprite = noone;

			if (_moving_up && !_moving_down) {
				if (_moving_forward) {
					_target_sprite = sprite_move_diag_forward;
				}
				else if (_moving_backward) {
					_target_sprite = sprite_move_diag_backward;
				}
				else {
					_target_sprite = sprite_move_up;
				}
			}
			else if (_moving_down && !_moving_up) {
				if (_moving_forward) {
					_target_sprite = sprite_move_diag_forward;
				}
				else if (_moving_backward) {
					_target_sprite = sprite_move_diag_backward;
				}
				else {
					_target_sprite = sprite_move_down;
				}
			}
			else if (_moving_forward) {
				_target_sprite = sprite_move_forward;
			}
			else if (_moving_backward) {
				_target_sprite = sprite_move_backward;
			}
			else {
				// Fallback for edge cases (pure sideways relative to facing)
				_target_sprite = sprite_move_forward;
			}

			// Apply sprite change if different from current
			if (sprite_current != _target_sprite && _target_sprite != noone) {
				var _loop_start = 3;
				var _loop_end = 16;
				if (_target_sprite == sprite_move_down) {
					_loop_start = 8;
					_loop_end = 10;
				}

				__mcp_log("[MOVE] Setting sprite with loop_start=" + string(_loop_start) + " loop_end=" + string(_loop_end));
				image_system_setup(_target_sprite, ANIMATION_FPS_DEFAULT, true, true, _loop_start, _loop_end);
			}
		}
		else {
			// Stationary - use idle sprite (left-facing, needs flip system)
			if (sprite_current != sprite_idle) {
				image_system_setup(sprite_idle, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
			}

			// Idle sprite is left-facing - enable face flip
			face_horizontal_draw_enable = true;
		}
	#endregion

	#region Custom Deaggro - Check Both X and Y Distance
		// Space Ranger uses 2D deaggro (both X and Y distance) plus line-of-sight check
		if(is_hostile){
			target_update(TargetType.attack);

			// Target lost — immediately deaggro
			if(target[TargetType.attack] == noone){
				movement_input_move_acceleration_factor_set(3.0);
				state = EnemyState.sheathe;
				return;
			}

			// Check both horizontal and vertical distance
			var _x_dist = abs(target[TargetType.attack].x - x);
			var _y_dist = abs(target[TargetType.attack].y - y);

			// Check if line of sight to player is blocked by a solid
			var _los_blocked = collision_line(x, y, target[TargetType.attack].x, target[TargetType.attack].y, o_solid, false, true) != noone;

			// Deaggro if player is out of range OR line of sight is blocked
			if(_x_dist > deaggro_x_distance_threshold || _y_dist > deaggro_y_distance_threshold || _los_blocked){
				// Player is out of range or hidden - increment timer
				deaggro_timer += global.delta_time_factor_scaled;

				if(deaggro_timer >= deaggro_timer_max){
					// De-aggro: keep speed high for return flight, then reset when arriving
					movement_input_move_acceleration_factor_set(3.0); // Fast return flight
					state = EnemyState.sheathe;
					return;
				}
			}
			else{
				// Player is within range and visible - reset timer
				deaggro_timer = 0;
			}
		}
	#endregion
}

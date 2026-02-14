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

	// Burst movement for hostile mode (short dashes with idle pauses between)
	if(is_hostile){
		target_update(TargetType.attack);

		// Face player during all burst phases
		if(target[TargetType.attack] != noone){
			if(target[TargetType.attack].x > x){
				face_horizontal = 1;
			}
			else{
				face_horizontal = -1;
			}
		}

		if(burst_phase == 0){
			// PAUSE - idle, wait for next burst
			input_move_magnitude = 0;

			burst_pause_timer -= global.delta_time_factor_scaled;
			if(burst_pause_timer <= 0 && target[TargetType.attack] != noone){
				// Pick direction toward player (try pathfinding, fallback to direct)
				actor_pathfind_and_move_to_target(target[TargetType.attack]);
				if(path_finding_path_found){
					burst_direction = input_move_direction;
				}
				else{
					burst_direction = point_direction(x, y, target[TargetType.attack].x, target[TargetType.attack].y);
				}

				// Start burst
				burst_phase = 1;
				burst_duration_timer = random_range(burst_duration_min, burst_duration_max);
				movement_input_move_acceleration_factor_set(3.5);
			}
		}
		else if(burst_phase == 1){
			// MOVING - accelerate toward burst direction
			input_move_direction = burst_direction;
			input_move_magnitude = 1;
			acceleration.AddMagnitudeDirection(INPUT_MOVE_ACCELERATION * input_move_magnitude, input_move_direction);

			burst_duration_timer -= global.delta_time_factor_scaled;
			if(burst_duration_timer <= 0){
				// Stop accelerating, let outro frames play
				image.loop = false;
				burst_phase = 2;
				velocity_retention = 1.0;  // Bypass setter to preserve velocity_retention_default
			}
		}
		else if(burst_phase == 2){
			// STOPPING - maintain velocity during remaining loop frames, decelerate during outro
			input_move_magnitude = 0;

			// Start decelerating once outro frames begin
			if(image.position >= image.loop_end && velocity_retention == 1.0){
				movement_velocity_retention_set(burst_coast_velocity_retention);
			}

			if(!image.animate){
				burst_phase = 0;
				burst_pause_timer = random_range(burst_pause_duration_min, burst_pause_duration_max);
				movement_input_move_acceleration_factor_set(1.0);
				movement_velocity_retention_set(velocity_retention_default);
			}
		}
	}

	#region Movement Sprite Selection
		// Hostile burst phases: handle sprite directly
		if(is_hostile && burst_phase == 0){
			// PAUSE phase - show idle sprite
			if(sprite_current != sprite_idle){
				image_system_setup(sprite_idle, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
			}
			face_horizontal_draw_enable = true;
		}
		else if(is_hostile && burst_phase == 2){
			// STOPPING phase - don't change sprite (outro animation playing)
		}
		// Normal movement sprite selection (patrol or hostile burst moving phase)
		else if (input_move_magnitude > 0 || abs(velocity.x) > 0.05 || abs(velocity.y) > 0.05) {
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
				var _was_moving = (sprite_current == sprite_move_forward
					|| sprite_current == sprite_move_backward
					|| sprite_current == sprite_move_up
					|| sprite_current == sprite_move_down
					|| sprite_current == sprite_move_diag_forward
					|| sprite_current == sprite_move_diag_backward);

				var _loop_start = 3;
				var _loop_end = 16;
				if (_target_sprite == sprite_move_down) {
					_loop_start = 8;
					_loop_end = 10;
				}

				__mcp_log("[MOVE] Setting sprite with loop_start=" + string(_loop_start) + " loop_end=" + string(_loop_end));
				image_system_setup(_target_sprite, ANIMATION_FPS_DEFAULT, true, true, _loop_start, _loop_end);

				// Skip intro frames when changing direction mid-move
				if (_was_moving) {
					image.position = 2;
					sprite_current_frame = 2;
				}
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
				burst_phase = 0;
				burst_pause_timer = 0;
				movement_input_move_acceleration_factor_set(3.0);
				movement_velocity_retention_set(velocity_retention_default);
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
					// De-aggro: reset burst state, keep speed high for return flight
					burst_phase = 0;
					burst_pause_timer = 0;
					movement_input_move_acceleration_factor_set(3.0); // Fast return flight
					movement_velocity_retention_set(velocity_retention_default);
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

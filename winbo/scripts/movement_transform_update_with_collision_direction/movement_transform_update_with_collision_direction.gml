/// @function movement_transform_update_with_collision_direction
/// @summary Apply movement with collision handling, updating transform values.
/// @param _delta_time Delta time in seconds.
/// @param _use_transform_anchor Whether to modify the Transform anchor values.
/// @returns {bool} True if a collision occurred.
function movement_transform_update_with_collision_direction(_delta_time, _use_transform_anchor){
	//DISABLED - Need to always handle collision in case of moving platforms
	////Check for No Movement
	//if(!move_grounded && velocity.EqualsValues(0,0) && acceleration.EqualsValues(0,0)){
	//	return false;
	//}
	
    // Compute displacement
    var _acceleration_multiplier = 0.5 * _delta_time;
    var _displacement_x = (velocity.x + acceleration.x * _acceleration_multiplier) * _delta_time;
    var _displacement_y = (velocity.y + acceleration.y * _acceleration_multiplier) * _delta_time;

    // Grounded Movement
    var _grounded_movement_x = 0;
    var _grounded_movement_y = 0;
    if(move_grounded && move_grounded_instance != noone){
        _grounded_movement_x = move_grounded_instance.x - move_grounded_instance.xprevious;
        _grounded_movement_y = move_grounded_instance.y - move_grounded_instance.yprevious;
        

    }

    // Get Old X & Y
    var _x_old, _y_old;

    if(_use_transform_anchor){
        // Get Transform
        var _transform = transform[TransformType.anchor];
        // Add Grounded Movement
        transform_set(_transform, TransformValue.x, _grounded_movement_x, true);
        transform_set(_transform, TransformValue.y, _grounded_movement_y, true);
        // Get Old Coordinate Values
        with(_transform){
            _x_old = value[TransformValue.x].current;
            _y_old = value[TransformValue.y].current;
        }
        // Add Grounded Movement to object position
        x += _grounded_movement_x;
        y += _grounded_movement_y;
    }
	else{
        // Add Grounded Movement to object position
        x += _grounded_movement_x;
        y += _grounded_movement_y;
        
        // Get Old Coordinate Values
        _x_old = x;
        _y_old = y;
    }

    // Initialize collision variables
    collision.Set(0, 0);
    move_collision_object_instance = noone;
    var _collision = false;

    // Store initial velocities
    var _initial_velocity_x = velocity.x;
    var _initial_velocity_y = velocity.y;

    // Apply movement and handle collisions
    if(move_collision_object != noone){
        // Horizontal movement
        if(true || _displacement_x != 0){
            var _hspd = _displacement_x;
            var _sign_hspd = sign(_hspd);
            
            // Apply movement limits on X-axis
            if(move_limit_enable_x){
                var _limit_min = move_limit_x.x;
                var _limit_max = move_limit_x.y;

                if(_x_old + _hspd < _limit_min){
                    _hspd = _limit_min - _x_old;
                    collision.x = -1;
                }
				else if(_x_old + _hspd > _limit_max){
                    _hspd = _limit_max - _x_old;
                    collision.x = 1;
                }
            }

            // Attempt to move horizontally
            var _new_x = _x_old + _hspd;

            // Check for collisions with collision_enable variables
            var _collision_instance_list = ds_list_create();
            var _collision_count = instance_place_list(_new_x, _y_old, move_collision_object, _collision_instance_list, false);
            var _collision_detected = false;

            if(_collision_count > 0){
                for(var _i = 0; _i < _collision_count; _i++){
                    var _collision_instance = _collision_instance_list[| _i];
                    var _collision_allowed = false;

                    // Store the collision instance's id for use outside the with block
                    var _collision_instance_id = _collision_instance.id;

                    // Skip collision if this is the drop-through instance
                    if(_collision_instance_id == move_drop_through_instance){
                        continue; // Skip this collision instance
                    }

                    with(_collision_instance){
                        if((collision_enable_x_in) ||
                            (collision_enable_x_left && (_sign_hspd == -1) && (_x_old >= bbox_right)) ||
                            (collision_enable_x_right && (_sign_hspd == 1) && (_x_old <= bbox_left))){
                            _collision_allowed = true;
                        }
                    }

                    if(_collision_allowed){
                        _collision_detected = true;
                        move_collision_object_instance = _collision_instance_id; // Set in the moving object's scope
                        break;
                    }
                }
            }

            ds_list_destroy(_collision_instance_list);

            if(!_collision_detected){
                // No collision, move freely
                _x_old = _new_x;
            }
			else{
                // Collision occurred
                collision.x = _sign_hspd;
                _collision = true;

                // Move to contact
                while(abs(_hspd) > 0.1){
                    _hspd -= _sign_hspd * 0.1;
                    _new_x = _x_old + _hspd;
                    if(!place_meeting(_new_x, _y_old, move_collision_object)){
                        _x_old = _new_x;
                        break;
                    }
                }
				
				if(move_collision_slip_enable){
					// --- Improved Corner Slip Logic for Horizontal Collision ---
					// Only try to slip if a horizontal collision was detected AND if vertical movement is zero.
					if (collision.x != 0 && _displacement_y == 0) {
						// Check for free space above and below (test a few pixels).
						var freeUp = true;
						var freeDown = true;
						for (var j = 0; j < 3; j++) {
							if (place_meeting(_x_old, _y_old - j, move_collision_object)) freeUp = false;
							if (place_meeting(_x_old, _y_old + j, move_collision_object)) freeDown = false;
						}
	
						// Only slip if exactly one side is open.
						if ((freeUp && !freeDown) || (!freeUp && freeDown)) {
							// Determine the intended slip direction: up if freeUp is true, down if freeDown is true.
							var slipDir = freeUp ? -1 : 1;
							// Only slip if vertical displacement is zero or matches the free side.
							if (_displacement_y == 0 || sign(_displacement_y) == slipDir) {
								var _maxSlip  = 8;  // Maximum slip distance in pixels.
								var _slipStep = 2;  // Slip step size in pixels.
								for (var _i = _slipStep; _i <= _maxSlip; _i += _slipStep) {
									if (!place_meeting(_x_old, _y_old + slipDir * _i, move_collision_object)) {
										_y_old += slipDir * _i;
										break;
									}
								}
							}
						}
					}
				}
            }
        }

		 // Adjust position slightly away from the solid (to prevent sticking)
	    if(collision.x != 0){
	        var _adjustment = -collision.x * 1;
	        _x_old += _adjustment;
	    }

        // Vertical movement
        if(true || _displacement_y != 0){
            var _vspd = _displacement_y;
            var _sign_vspd = sign(_vspd);

            // Apply movement limits on Y-axis
            if(move_limit_enable_y){
                var _limit_min = move_limit_y.x;
                var _limit_max = move_limit_y.y;

                if(_y_old + _vspd < _limit_min){
                    _vspd = _limit_min - _y_old;
                    collision.y = -1;
                }
				else if(_y_old + _vspd > _limit_max){
                    _vspd = _limit_max - _y_old;
                    collision.y = 1;
                }
            }

            // Attempt to move vertically
            var _new_y = _y_old + _vspd;

            // Check for collisions with collision_enable variables
            var _collision_instance_list = ds_list_create();
            var _collision_count = instance_place_list(_x_old, _new_y, move_collision_object, _collision_instance_list, false);
            var _collision_detected = false;

            if(_collision_count > 0){
                for (var _i = 0; _i < _collision_count; _i++){
                    var _collision_instance = _collision_instance_list[| _i];
                    var _collision_allowed = false;

                    // Store the collision instance's id for use outside the with block
                    var _collision_instance_id = _collision_instance.id;

                    // Skip collision if this is the drop-through instance
                    if(_collision_instance_id == move_drop_through_instance){
                        continue; // Skip this collision instance
                    }

                    with (_collision_instance){
                        if((collision_enable_y_in) ||
                            (collision_enable_y_up && (_sign_vspd == -1) && (other.bbox_top >= bbox_bottom)) ||
                            (collision_enable_y_down && (_sign_vspd == 1) && (other.bbox_bottom <= bbox_top))){
                            _collision_allowed = true;
                        }
                    }

                    if(_collision_allowed){
                        _collision_detected = true;
                        move_collision_object_instance = _collision_instance_id; // Set in the moving object's scope
                        break;
                    }
                }
            }

            ds_list_destroy(_collision_instance_list);

            if(!_collision_detected){
                // No collision, move freely
                _y_old = _new_y;
            }
			else{
                // Collision occurred
                collision.y = _sign_vspd;
                _collision = true;

                // Move to contact
                while (abs(_vspd) > 0.1){
                    _vspd -= _sign_vspd * 0.1;
                    _new_y = _y_old + _vspd;
                    if(!place_meeting(_x_old, _new_y, move_collision_object)){
                        _y_old = _new_y;
                        break;
                    }
                }
			
				if(move_collision_slip_enable){
					// --- Improved Corner Slip Logic for Vertical Collision ---
					// Only try to slip if a vertical collision was detected AND if horizontal movement is zero.
					if (collision.y != 0 && _displacement_x == 0) {
						// Check for free space to the left and right (test a few pixels).
						var freeLeft  = true;
						var freeRight = true;
						for (var j = 0; j < 3; j++) {
							if (place_meeting(_x_old - j, _y_old, move_collision_object)) freeLeft = false;
							if (place_meeting(_x_old + j, _y_old, move_collision_object)) freeRight = false;
						}
	
						// Only slip if exactly one side is open.
						if ((freeLeft && !freeRight) || (!freeLeft && freeRight)) {
							// Determine the intended slip direction: left if freeLeft is true, right if freeRight is true.
							var slipDir = freeLeft ? -1 : 1;
							// Only slip if horizontal displacement is zero or matches the free side.
							if (_displacement_x == 0 || sign(_displacement_x) == slipDir) {
								var _maxSlip  = 8;  // Maximum slip distance in pixels.
								var _slipStep = 2;  // Slip step size in pixels.
								for (var _i = _slipStep; _i <= _maxSlip; _i += _slipStep) {
									if (!place_meeting(_x_old + slipDir * _i, _y_old, move_collision_object)) {
										_x_old += slipDir * _i;
										break;
									}
								}
							}
						}
					}
				}
            }
        }
    }
	else{
        // No collision object; move freely
        _x_old += _displacement_x;
        _y_old += _displacement_y;
    }

   
    if(collision.y != 0){
        var _adjustment = -collision.y * 1;
        _y_old += _adjustment;
    }

    // Update object's position
    if(_use_transform_anchor){
        // Update Transform
        transform_set(_transform, TransformValue.x, _x_old, false);
        transform_set(_transform, TransformValue.y, _y_old, false);
    }
	else{
        x = _x_old;
        y = _y_old;
    }

    // Overlap resolution: If we're inside a solid (not grounded on it), push out
    if(move_collision_object != noone){
        var _overlap = instance_place(x, y, move_collision_object);
        if(_overlap != noone && _overlap != move_grounded_instance && (_overlap != move_drop_through_instance)){
            // We're overlapping with a solid that we're not standing on
            // Get platform movement to help decide push direction
            var _platform_dx = _overlap.x - _overlap.xprevious;
            var _platform_dy = _overlap.y - _overlap.yprevious;
            
            // If platform is actively moving, move player with it first
            if(abs(_platform_dx) > 0.1 || abs(_platform_dy) > 0.1){
                // Check horizontal platform movement collision enable
                var _horizontal_collision_allowed = false;
                if(abs(_platform_dx) > 0.1){
                    var _platform_sign_hspd = sign(_platform_dx);
                    with(_overlap){
                        if((collision_enable_x_in) ||
                            (collision_enable_x_left && (_platform_sign_hspd == 1) && (other.x >= bbox_right)) ||
                            (collision_enable_x_right && (_platform_sign_hspd == -1) && (other.x <= bbox_left))){
                            _horizontal_collision_allowed = true;
                        }
                    }
                    
                    // Only move horizontally with platform if collision is enabled
                    if(_horizontal_collision_allowed){
                        x += _platform_dx;
                        if(_use_transform_anchor){
                            transform_set(_transform, TransformValue.x, _platform_dx, true);
                        }
                        velocity.x = _platform_dx / _delta_time;
                    }
                }
                
                // Check vertical platform movement collision enable
                var _vertical_collision_allowed = false;
                if(abs(_platform_dy) > 0.1){
                    var _platform_sign_vspd = sign(_platform_dy);
                    var _player_bottom = bbox_bottom;
                    var _platform_top = _overlap.bbox_top;
                    var _is_on_top = (_player_bottom <= _platform_top + 4);
                    
                    with(_overlap){
                        if((collision_enable_y_in) ||
                            (collision_enable_y_up && (_platform_sign_vspd == 1) && (other.y >= bbox_bottom)) ||
                            (collision_enable_y_down && (_platform_sign_vspd == -1) && (other.y <= bbox_top))){
                            _vertical_collision_allowed = true;
                        }
                    }
                    
                    // Only move vertically with platform if collision is enabled and conditions are met
                    if(_vertical_collision_allowed && (_is_on_top || _platform_dy < 0)){                        
                        y += _platform_dy;
                        if(_use_transform_anchor){
                            transform_set(_transform, TransformValue.y, _platform_dy, true);
                        }
                        
                        // Only set vertical velocity if we're on top of the platform
                        if(_is_on_top){
                            velocity.y = _platform_dy / _delta_time;
                        }
                    }
                }
            }
            
            // After moving with platform, check if we're still overlapping
            // This handles cases where player was already partially inside
            if(place_meeting(x, y, _overlap)){
                // Check which push directions are allowed based on collision enables
                var _push_left_allowed = false, _push_right_allowed = false;
                var _push_up_allowed = false, _push_down_allowed = false;
                
                with(_overlap){
                    // Push left is allowed if collision is enabled for leftward movement and position allows it
                    if((collision_enable_x_in) || 
                       (collision_enable_x_left && (other.x >= bbox_right))){
                        _push_left_allowed = true;
                    }
                    
                    // Push right is allowed if collision is enabled for rightward movement and position allows it
                    if((collision_enable_x_in) || 
                       (collision_enable_x_right && (other.x <= bbox_left))){
                        _push_right_allowed = true;
                    }
                    
                    // Push up is allowed if collision is enabled for upward movement and position allows it
                    if((collision_enable_y_in) || 
                       (collision_enable_y_up && (other.y >= bbox_bottom))){
                        _push_up_allowed = true;
                    }
                    
                    // Push down is allowed if collision is enabled for downward movement and position allows it
                    if((collision_enable_y_in) || 
                       (collision_enable_y_down && (other.y <= bbox_top))){
                        _push_down_allowed = true;
                    }
                }
                
                // Find the best direction to push out (only for allowed directions)
                var _push_left = _push_left_allowed ? 0 : 999;
                var _push_right = _push_right_allowed ? 0 : 999;
                var _push_up = _push_up_allowed ? 0 : 999;
                var _push_down = _push_down_allowed ? 0 : 999;
                
                // Check how far we need to move in each allowed direction to get out
                if(_push_left_allowed){
                    while(place_meeting(x - _push_left, y, _overlap) && _push_left < 32) _push_left++;
                }
                if(_push_right_allowed){
                    while(place_meeting(x + _push_right, y, _overlap) && _push_right < 32) _push_right++;
                }
                if(_push_up_allowed){
                    while(place_meeting(x, y - _push_up, _overlap) && _push_up < 32) _push_up++;
                }
                if(_push_down_allowed){
                    while(place_meeting(x, y + _push_down, _overlap) && _push_down < 32) _push_down++;
                }
                
                // Prefer pushing in the direction the platform came from (only if allowed)
                // This prevents fighting against platform movement
                if(_platform_dx > 0.5 && _push_left_allowed) _push_left = max(0, _push_left - 8);  // Platform moving right, prefer push left
                if(_platform_dx < -0.5 && _push_right_allowed) _push_right = max(0, _push_right - 8); // Platform moving left, prefer push right
                if(_platform_dy > 0.5 && _push_up_allowed) _push_up = max(0, _push_up - 8);     // Platform moving down, prefer push up
                if(_platform_dy < -0.5 && _push_down_allowed) _push_down = max(0, _push_down - 8); // Platform moving up, prefer push down
                
                // Find the shortest push distance among allowed directions
                var _min_push = min(_push_left, _push_right, _push_up, _push_down);
                
                // Apply the push in the direction that requires the least movement
                if(_min_push < 32){
                    if(_min_push == _push_left && _push_left > 0 && _push_left_allowed){
                        x -= _push_left;
                        if(_use_transform_anchor){
                            transform_set(_transform, TransformValue.x, -_push_left, true);
                        }
                    }
                    else if(_min_push == _push_right && _push_right > 0 && _push_right_allowed){
                        x += _push_right;
                        if(_use_transform_anchor){
                            transform_set(_transform, TransformValue.x, _push_right, true);
                        }
                    }
                    else if(_min_push == _push_up && _push_up > 0 && _push_up_allowed){
                        y -= _push_up;
                        if(_use_transform_anchor){
                            transform_set(_transform, TransformValue.y, -_push_up, true);
                        }
                    }
                    else if(_min_push == _push_down && _push_down > 0 && _push_down_allowed){
                        y += _push_down;
                        if(_use_transform_anchor){
                            transform_set(_transform, TransformValue.y, _push_down, true);
                        }
                    }
                }
            }
        }
    }

    // Handle other collisions (e.g., grounded, trapped)
    // Grounded Check
    if(move_grounded_check){
		var _ground_probe_instance_is_below;
		_ground_probe_instance_is_below = false;
		
        var _ground_probe_instance;
		_ground_probe_instance = instance_place(x, y + 10, move_collision_object);
		
		if((_ground_probe_instance != noone) && (_ground_probe_instance != move_drop_through_instance)){
			var _ground_probe_instance_is_below;
			_ground_probe_instance_is_below = false;
			
			var _platform_bbox_top = 0;
			var _distance_from_platform = 0;
				
			with(_ground_probe_instance){
				_ground_probe_instance_is_below = (other.bbox_bottom <= bbox_top + 1);
				_platform_bbox_top = bbox_top;
				_distance_from_platform = other.bbox_bottom - bbox_top;
			}
			
			if(_ground_probe_instance_is_below){
				var _was_grounded = move_grounded;
				var _prev_instance = move_grounded_instance;
				
				move_grounded = true;
				move_grounded_instance = _ground_probe_instance;
			}
			else{
				var _was_grounded = move_grounded;
				var _prev_instance = move_grounded_instance;
				
				move_grounded = false;
				move_grounded_instance = noone;
			}
		}
		else{
			var _was_grounded = move_grounded;
			var _prev_instance = move_grounded_instance;
			
			move_grounded = false;
			move_grounded_instance = noone;
		}
		
		//sdm("_ground_probe_instance_is_below: " + string(_ground_probe_instance_is_below));
    }
	//sdm("move_grounded: " + string(move_grounded));
	
	// Grounded Close Check
    if(move_grounded_close_check){
		if(move_grounded){
			move_grounded_close = move_grounded;
			move_grounded_close_instance = move_grounded_instance;
		}
		else if(place_meeting(x, y + move_grounded_close_check_distance, move_collision_object)){
            move_grounded_close = true;
            move_grounded_close_instance = instance_place(x, y + move_grounded_close_check_distance, move_collision_object);
        }
		else{
            move_grounded_close = false;
            move_grounded_close_instance = noone;
        }
    }

    // Trapped Check
    if(move_trapped_check){
		//move_trapped = false;
		
		//with(instance_place(x,y, move_collision_object)){
		//	if(move_trapped_trigger_enable){
		//		other.move_trapped = true;
		//	}
		//}
		
		
		//var _move_trap_instance;
		//_move_trap_instance = instance_place(x,y, move_collision_object);
        //if(_move_trap_instance != noone){
        //    move_trapped = true;
        //}
		//else{
        //    move_trapped = false;
        //}
    }

    // Clear drop-through instance if no longer overlapping
    if(move_drop_through_instance != noone){
        if(!place_meeting(x, y, move_drop_through_instance)){
            move_drop_through_instance = noone;
        }
    }

    // Return collision status
    return _collision;
}

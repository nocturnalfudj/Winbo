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

    // Platforms advance before this solver. Keep last-frame foot contact so a
    // new rider caught from below is resolved at the actual rising top.
    var _feet_before_movement = bbox_bottom;
    var _was_grounded = move_grounded;
    // Only an existing rider may follow a small, connected floor step.
    // Airborne contact keeps the ordinary two-pixel support tolerance.
    var _step_from = (move_grounded_check && _was_grounded
        && velocity.y >= 0 && _displacement_y >= 0) ? move_grounded_instance : noone;
    var _landed_on_rising_platform = false;

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

    // Use the surface reached by this step, rather than last frame's ground.
    // The same foot-contact test drives grounding below, including flush seams.
    if(move_grounded && _displacement_y >= 0){
        var _surface_support = (_step_from != noone)
            ? movement_ground_support_at(x + _displacement_x, y, 6, _step_from)
            : movement_ground_support_at(x + _displacement_x, y, 2);
        if(_surface_support != noone){
            _displacement_x += _surface_support.surface_speed_x * _delta_time;
        }
    }

    // Initialize collision variables
    collision.Set(0, 0);
    move_collision_object_instance = noone;
    move_collision_object_instance_x = noone;
    move_collision_object_instance_y = noone;
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
                        move_collision_object_instance_x = _collision_instance_id;
                        break;
                    }
                }
            }

            // A four-pixel floor lip is the reverse of the authored belt
            // step-down. Lift only an existing non-rising rider, and only if
            // the entire projected mask clears the lip and every other wall.
            // The generic corner-slip path otherwise lifts partway and briefly
            // loses support before the next movement step reaches the floor.
            if(_collision_detected && _step_from != noone){
                for(var _i = 0; _i < _collision_count; _i++){
                    var _step_solid = _collision_instance_list[| _i];
                    if(_step_solid == move_drop_through_instance) continue;
                    // The candidate itself must block this horizontal approach.
                    // A separate solid lip cannot turn a one-way underside into a step.
                    if(!(_step_solid.collision_enable_x_in
                    || (_step_solid.collision_enable_x_left && _sign_hspd == -1 && _x_old >= _step_solid.bbox_right)
                    || (_step_solid.collision_enable_x_right && _sign_hspd == 1 && _x_old <= _step_solid.bbox_left))) continue;
                    if(!_step_solid.collision_enable_y_in && !_step_solid.collision_enable_y_down) continue;
                    var _step_height = _step_solid.bbox_top - _step_from.bbox_top;
                    if(_step_height >= 0 || _step_height < -4) continue;
                    var _foot_width = bbox_right - bbox_left + 1;
                    if(_step_solid.bbox_left - _step_from.bbox_right - 1 >= _foot_width
                    || _step_from.bbox_left - _step_solid.bbox_right - 1 >= _foot_width) continue;
                    var _step_up = _step_solid.bbox_top - 1 - bbox_bottom;
                    if(_step_up >= 0 || _step_up < -4) continue;
                    if(move_limit_enable_y && _y_old + _step_up < move_limit_y.x) continue;
                    if(!place_meeting(_new_x, _y_old + _step_up, move_collision_object)
                    && movement_ground_support_at(_new_x, _y_old + _step_up, 2) == _step_solid){
                        _y_old += _step_up;
                        _collision_detected = false;
                        move_collision_object_instance = noone;
                        move_collision_object_instance_x = noone;
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

        // Settle a connected four-pixel step only after horizontal walls have
        // resolved. Sending the drop through the vertical solver preserves
        // one-way/drop-through rules and never bridges an unsupported gap.
        if(_step_from != noone && movement_ground_support_at(_x_old, _y_old, 2) == noone){
            var _step_support = movement_ground_support_at(_x_old, _y_old, 6, _step_from);
            if(_step_support != noone){
                var _restore_x = x, _restore_y = y;
                x = _x_old;
                y = _y_old;
                var _step_down = _step_support.bbox_top - 1 - bbox_bottom;
                x = _restore_x;
                y = _restore_y;
                _displacement_y = max(_displacement_y, _step_down);
            }
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
                        move_collision_object_instance_y = _collision_instance_id;
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
    // Contact queries must see the solved position now, before the later
    // transform-system update. Otherwise seams and landings use last frame's feet.
    x = _x_old;
    y = _y_old;

    // Overlap resolution: If we're inside a solid (not grounded on it), push out
    if(move_collision_object != noone){
        var _overlap = instance_place(x, y, move_collision_object);
        if(_overlap != noone && _overlap != move_grounded_instance && (_overlap != move_drop_through_instance)){
            // We're overlapping with a solid that we're not standing on
            // Get platform movement to help decide push direction
            var _platform_dx = _overlap.x - _overlap.xprevious;
            var _platform_dy = _overlap.y - _overlap.yprevious;
            var _overlap_push_limit = max(
                32,
                ceil(max(abs(_platform_dx),abs(_platform_dy))) + 2
            );
            
            var _landing_offset = _overlap.bbox_top - 1 - bbox_bottom;
            var _rising_top_contact = move_grounded_check && !_was_grounded
                && _platform_dy < 0 && _displacement_y > _platform_dy
                && _feet_before_movement <= _overlap.bbox_top - _platform_dy
                && (_overlap.collision_enable_y_in || _overlap.collision_enable_y_down)
                && place_meeting(x, y + _landing_offset + 2, _overlap);

            if(_rising_top_contact){
                // This was airborne contact, not a rider at the start of the
                // platform's travel. Copying its whole delta overshoots the
                // surface and leaves an artificial gap after the collision.
                y += _landing_offset;
                if(_use_transform_anchor)
                    transform_set(_transform, TransformValue.y, _landing_offset, true);
                velocity.y = 0;
                acceleration.y = 0;
                collision.y = 1;
                move_collision_object_instance = _overlap;
                move_collision_object_instance_y = _overlap;
                _collision = true;
                _landed_on_rising_platform = true;
            }
            // Existing side/underside pushes retain their directional rules.
            else if(abs(_platform_dx) > 0.1 || abs(_platform_dy) > 0.1){
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
                var _push_unavailable = _overlap_push_limit + 1;
                var _push_left = _push_left_allowed ? 0 : _push_unavailable;
                var _push_right = _push_right_allowed ? 0 : _push_unavailable;
                var _push_up = _push_up_allowed ? 0 : _push_unavailable;
                var _push_down = _push_down_allowed ? 0 : _push_unavailable;
                
                // Check how far we need to move in each allowed direction to get out
                if(_push_left_allowed){
                    while(place_meeting(x - _push_left, y, _overlap) && _push_left < _overlap_push_limit) _push_left++;
                }
                if(_push_right_allowed){
                    while(place_meeting(x + _push_right, y, _overlap) && _push_right < _overlap_push_limit) _push_right++;
                }
                if(_push_up_allowed){
                    while(place_meeting(x, y - _push_up, _overlap) && _push_up < _overlap_push_limit) _push_up++;
                }
                if(_push_down_allowed){
                    while(place_meeting(x, y + _push_down, _overlap) && _push_down < _overlap_push_limit) _push_down++;
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
                if(_min_push < _overlap_push_limit){
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
        // A nearby surface is not a landing. Only accept contact while falling
        // or resting, and settle residual falling velocity through the normal
        // collision integration so moving-platform landings can jump again.
        var _ground_support = (_displacement_y >= 0 || _landed_on_rising_platform)
            ? movement_ground_support_at(x, y, 2) : noone;
        move_grounded = _ground_support != noone;
        move_grounded_instance = _ground_support;
        if(move_grounded){
            collision.y = 1;
            _collision = true;
            // Overlap resolution may have copied an upward platform velocity.
            // Carry is positional; a landed rider has no vertical self-motion.
            velocity.y = 0;
            acceleration.y = 0;
        }
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

/// Find actual support under the projected feet. Mask-test every candidate,
/// exclude side walls and dropped/one-way undersides, then choose the nearest
/// top. A touching belt takes traction immediately; ties use foot overlap.
function movement_ground_support_at(_x, _y, _distance, _step_from = noone){
    if(move_collision_object == noone) return noone;

    // Bounds are quantized by the collision mask. Translating today's bbox
    // by fractional carry can reject a genuine two-pixel projected contact.
    var _restore_x = x, _restore_y = y;
    x = _x;
    y = _y;
    var _contacts = ds_list_create();
    var _count = instance_place_list(x, y + _distance, move_collision_object, _contacts, false);
    var _bottom = bbox_bottom;
    var _left = bbox_left;
    var _right = bbox_right;
    x = _restore_x;
    y = _restore_y;
    var _support = noone;
    var _nearest = _distance + 1;
    var _widest = -1;
    var _surface_moving = false;

    for(var _i = 0; _i < _count; _i++){
        var _solid = _contacts[| _i];
        if(_solid == move_drop_through_instance) continue;
        if(!_solid.collision_enable_y_in && !_solid.collision_enable_y_down) continue;

        var _gap = _solid.bbox_top - _bottom;
        if(_gap < 0 || _gap > _distance) continue;
        if(_gap > 2 && _step_from != noone){
            var _step_height = _solid.bbox_top - _step_from.bbox_top;
            if(_step_from == move_drop_through_instance || _step_height < 0 || _step_height > 4) continue;
            // The authored floor/belt seam includes a small horizontal gap.
            // Feet can straddle it without any unsupported position; a gap
            // at least as wide as the foot mask must remain a real fall.
            var _foot_width = _right - _left + 1;
            if(_solid.bbox_left - _step_from.bbox_right - 1 >= _foot_width
            || _step_from.bbox_left - _solid.bbox_right - 1 >= _foot_width) continue;
        }

        var _overlap = min(_right, _solid.bbox_right) - max(_left, _solid.bbox_left) + 1;
        var _moving = _solid.surface_speed_x != 0;
        if(_gap < _nearest || (_gap == _nearest
        && ((_moving && !_surface_moving) || (_moving == _surface_moving && _overlap > _widest)))){
            _support = _solid;
            _nearest = _gap;
            _widest = _overlap;
            _surface_moving = _moving;
        }
    }

    ds_list_destroy(_contacts);
    return _support;
}

function bullet_state_move(){
	//Detla Time Factor
	var _delta_time;
	_delta_time = global.delta_time_factor_scaled;

	#region Homing Behavior
		if(homing_enable){
			// Decrement homing delay
			if(homing_delay > 0){
				homing_delay -= _delta_time;
			}
			else{
				// Find target if not set
				if(homing_target == noone || !instance_exists(homing_target)){
					homing_target = instance_find(o_player, 0);
				}

				// Track toward target
				if(homing_target != noone && instance_exists(homing_target)){
					// Calculate angle to target
					var _target_angle = point_direction(x, y, homing_target.x, homing_target.y);

					// Get current velocity direction
					var _current_angle = velocity_dir;

					// Calculate shortest angle difference (handles wrap-around)
					var _angle_diff = angle_difference(_target_angle, _current_angle);

					// Apply turn rate (clamp to prevent overshooting)
					var _turn_amount = clamp(_angle_diff, -homing_turn_rate, homing_turn_rate);

					// Calculate new direction
					var _new_angle = _current_angle + _turn_amount;

					// Update velocity to new direction while maintaining speed
					var _speed = velocity_mag;
					velocity.x = lengthdir_x(_speed, _new_angle);
					velocity.y = lengthdir_y(_speed, _new_angle);
				}
			}
		}
	#endregion

	//Update Transform With Collision
	var _collision;
	_collision = movement_transform_update_with_collision_direction(_delta_time,move_use_transform);

	//Update Velocity
	movement_velocity_update(_delta_time,false);

	// Deflected fly-off projectiles should despawn once they leave the room bounds.
	if(deflect_flyoff_active){
		var _margin = max(0, deflect_flyoff_margin);
		if((x < -_margin) || (x > room_width + _margin) || (y < -_margin) || (y > room_height + _margin)){
			instance_destroy();
			exit;
		}
	}
	
	#region Handle Solid Collision6
		if(_collision){			
			state = BulletState.hit;
			hit_solid = true;
		}
	#endregion
	
	//Reset Acceleration
	if((!post_hit_movement_update_enable) || ((post_hit_movement_update_enable) && (state != BulletState.hit)))
		acceleration.Set(0,0);
	
	//Kill If Not Moving
	if(velocity_retention != 1){
		if(velocity_mag < 6){
			state = BulletState.death;
			movement_stop_death = true;
			post_hit_movement_update_enable = true;
		}
	}
	
	#region Update Angle
		if(state == BulletState.move){
			// Deflected fly-off uses sprite spin instead of velocity-facing.
			if(deflect_flyoff_active){
				if(deflect_flyoff_sprite_spin_speed != 0){
					transform_set(transform[TransformType.anchor],TransformValue.angle,deflect_flyoff_sprite_spin_speed * _delta_time,true);
				}
			}
			// Set direction to velocity (with optional sprite offset for backwards-facing sprites).
			else if(rotate_to_velocity_direction){
				transform_set(transform[TransformType.anchor],TransformValue.angle,velocity_dir + sprite_angle_offset,false);
			}
		}
	#endregion
	
	#region Alive Time
		if(alive_time != infinity){
			alive_time -= _delta_time;
			
			if(alive_time <= 0){
				state = BulletState.death;
				movement_stop_death = true;
			}
		}
	#endregion
}

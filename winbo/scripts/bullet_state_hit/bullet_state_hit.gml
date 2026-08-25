function bullet_state_hit(){
	// Missile explosion screen shake
	if (object_index == o_missile) {
		camera_shake_add(0.3, 8);

		// Persistent ash is a ground-impact mark. Treat a visually straight-down
		// homing missile as direct even when steering leaves a few degrees of drift;
		// upward, diagonal and side impacts still leave no mark.
		var _ash_down_direction = 270;
		var _ash_down_tolerance = 5;
		var _impact_direction = point_direction(0,0,velocity.x,velocity.y);
		if((collision.y > 0)
		&& (velocity.y > 0)
		&& (abs(angle_difference(_impact_direction,_ash_down_direction)) <= _ash_down_tolerance)){
			fx_spawn_ash_decal(x, y, 270, move_collision_object_instance);
		}
	}

	//Post Hit Movement Update
	if(post_hit_movement_update_enable){
		//Remove Solide Detection
		move_collision_object = noone;
		
		//Set Acceleration
		//acceleration.Set(velocity.x,velocity.y);
		
		var _delta_time;
		_delta_time = global.delta_time_factor_scaled;
		
		//Update Transform With Collision
		movement_transform_update_with_collision_direction(_delta_time,move_use_transform);
		
		//Update Velocity
		movement_velocity_update(_delta_time,false);
	}
	
	//Flash
	flash_alpha = 1;
	
	//Kill Bullet
	state = BulletState.death;
}

function bullet_state_hit(){
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
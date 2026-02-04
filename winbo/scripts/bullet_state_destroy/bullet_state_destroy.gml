function bullet_state_destroy(){
	//Post Hit Movement Update
	if(post_hit_movement_update_enable){
		var _delta_time;
		_delta_time = global.delta_time_factor_scaled;
		
		//Update Transform With Collision
		movement_transform_update_with_collision_direction(_delta_time,move_use_transform);

		//Update Velocity
		movement_velocity_update(_delta_time,false);
	}
	
	//Destroy instance when Transform is at rest
	transform_updated_check();
	
	if(!transform_updated || (image_alpha == 0)){
		instance_destroy();
	}	
}
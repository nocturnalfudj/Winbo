function bullet_state_death(){
	//Post Hit Movement Update
	if(post_hit_movement_update_enable){
		var _delta_time;
		_delta_time = global.delta_time_factor_scaled;
		
		//Update Transform With Collision
		movement_transform_update_with_collision_direction(_delta_time,move_use_transform);

		//Update Velocity
		movement_velocity_update(_delta_time,false);
	}
	
	#region Disappear Animation
		//Expand & Fade
		if(death_animation_expand){
			var _transform,_time_max,_time_current,_ease,_target;
			_transform = transform[TransformType.anchor];
			_time_current = 0;
			_ease = ease_quad_in;
			_target = 6;
			_time_max = death_animation_expand_time_max_scale;
			transform_animate_from_current(_transform,TransformValue.xscale,_target,_time_current,_time_max,_ease,false);
			transform_animate_from_current(_transform,TransformValue.yscale,_target,_time_current,_time_max,_ease,false);
			_ease = ease_quad_out;
			_time_max = death_animation_expand_time_max_alpha;
			transform_animate_from_current(_transform,TransformValue.alpha,0,_time_current,_time_max,_ease,false);
		}
		else{
			//Shrink & Fade
			if(movement_stop_death){
				transform_animate_from_current_shrink_and_fade(0.2*SECOND);
			}
			else{
				transform_animate_from_current_shrink_and_fade(0.15*SECOND);
			}
		}
	#endregion
		
	//State to Destroy
	state = BulletState.destroy;
}
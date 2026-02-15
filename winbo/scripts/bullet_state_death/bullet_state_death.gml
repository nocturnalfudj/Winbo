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

	#region Optional Death Animation
		if((death_anim_sprite != noone) && (!death_anim_suppressed)){
			if(!death_anim_started){
				death_anim_started = true;

				// Missile explosion should be 20% smaller than the base bullet/missile scale.
				if(death_anim_sprite == spr_missile_explosion){
					var _t = transform[TransformType.anchor];
					transform_set(_t, TransformValue.xscale, _t.value[TransformValue.xscale].current * 0.8, false);
					transform_set(_t, TransformValue.yscale, _t.value[TransformValue.yscale].current * 0.8, false);
				}

				image_system_setup(death_anim_sprite,death_anim_fps,true,false,0,IMAGE_LOOP_FULL);
				image_set_frame(image,0);
				exit;
			}
			
			if((image == noone) || (!image.animate)){
				state = BulletState.destroy;
			}
			
			exit;
		}
	#endregion
	
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

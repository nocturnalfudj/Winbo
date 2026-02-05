function enemy_apocalypse_survivor_state_idle(){
	// Update health
	character_health();

	// Delta time
	var _delta_time = time_scale_enable ? global.delta_time_factor_scaled : global.delta_time_factor;

	// Patrol pause handling (non-hostile only)
	if(!is_hostile){
		// Set idle animation (separate idle sprite, loops fully)
		if(sprite_current != sprite_idle){
			image_system_setup(sprite_idle, ANIMATION_FPS_DEFAULT * animation_fps_multiplier, true, true, 0, IMAGE_LOOP_FULL);
		}

		if(patrol_pause_timer > 0){
			patrol_pause_timer -= _delta_time;
		}
		if(patrol_pause_timer <= 0){
			state = EnemyState.move;
		}
	}
	else{
		// Hostile idle shouldn't happen, but keep facing target if it does
		target_update(TargetType.attack);
		face_horizontal = (target[TargetType.attack].x >= x) ? 1 : -1;
	}
}

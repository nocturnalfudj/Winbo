function enemy_state_death(){
	// Winbo stomp-kill smoke: delay a couple steps so the death sprite is visible briefly.
	if (death_smoke_enable && !death_smoke_spawned) {
		death_smoke_step_count++;
	}

	// If we have a death animation sprite, play it once before shrinking/fading.
	// Otherwise, fall back to the legacy instant shrink/fade.
	var _death_sprite;
	_death_sprite = noone;
	
	if(sprite_direction_enable && (sprite_death_left != noone) && (sprite_death_right != noone)){
		_death_sprite = enemy_sprite_get_directional(sprite_death_left, sprite_death_right);
	}
	else if(sprite_death_left != noone){
		// Non-directional fallback uses the "left" slot.
		_death_sprite = sprite_death_left;
	}
	
	// No death sprite configured: shrink/fade immediately (unless overridden by stomp-kill smoke).
	if(_death_sprite == noone){
		if (death_smoke_enable) {
			if (!death_smoke_spawned && (death_smoke_step_count > death_smoke_delay_steps)) {
				death_smoke_spawned = true;
				fx_spawn_sprite_once(x, y, "lyr_pfx_foreground", spr_smoke_explosion_large, 1, 1, 0, ANIMATION_FPS_DEFAULT);
				transform_animate_from_current_shrink_and_fade();
				state = EnemyState.destroy;
			}
			exit;
		}
		else {
			transform_animate_from_current_shrink_and_fade();
			state = EnemyState.destroy;
			exit;
		}
	}
	
	// Ensure the death sprite is set once (do not loop).
	if(sprite_current != _death_sprite){
		image_system_setup(_death_sprite, ANIMATION_FPS_DEFAULT * animation_fps_multiplier, true, false, 0, IMAGE_LOOP_FULL);
		// Critical: reset the frame immediately so we don't read a stale sprite_current_frame
		// from the previous animation during this same step.
		image_set_frame(image, 0);
		// Wait until subsequent steps to evaluate completion.
		exit;
	}

	// Stomp-kill: interrupt the full death animation and cover it with smoke.
	if (death_smoke_enable && !death_smoke_spawned && (death_smoke_step_count > death_smoke_delay_steps)) {
		death_smoke_spawned = true;
		fx_spawn_sprite_once(x, y, "lyr_pfx_foreground", spr_smoke_explosion_large, 1, 1, 0, ANIMATION_FPS_DEFAULT);
		transform_animate_from_current_shrink_and_fade();
		state = EnemyState.destroy;
		exit;
	}
	
	// When the animation finishes, shrink/fade then go to destroy
	// (destroy waits for transform to settle). Use image.animate which is only set
	// to false by image_animate once the non-looping animation has completed.
	if(!image.animate){
		transform_animate_from_current_shrink_and_fade();
		state = EnemyState.destroy;
	}
}

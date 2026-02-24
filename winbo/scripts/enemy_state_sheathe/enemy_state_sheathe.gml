/// @description Enemy sheathe state - plays sheathe animation then returns to relaxed patrol
function enemy_state_sheathe(){
	//Update Health
	character_health();

	// Get sheathe sprite based on facing direction
	var _sheathe_sprite;
	_sheathe_sprite = sprite_sheathe_left;
	if(sprite_direction_enable && (sprite_sheathe_left != noone) && (sprite_sheathe_right != noone)){
		_sheathe_sprite = enemy_sprite_get_directional(sprite_sheathe_left, sprite_sheathe_right);
	}

	// Set up sheathe animation if not already playing
	if(_sheathe_sprite == noone){
		// No sheathe animation available: complete sheathe immediately.
		is_hostile = false;
		hostility_detection_enable = true;
		deaggro_timer = 0;
		attack_countdown = 0;
		state = EnemyState.move;
		return;
	}

	if(sprite_current != _sheathe_sprite){
		image_system_setup(_sheathe_sprite, ANIMATION_FPS_DEFAULT * animation_fps_multiplier, true, false, 0, IMAGE_LOOP_FULL);
	}

	// Progress when animation finishes
	if(sprite_current_frame >= (image.sprite_number - 1)){
		// Return to relaxed state
		is_hostile = false;

		// Re-enable hostility detection so we can aggro again
		hostility_detection_enable = true;

		// Reset de-aggro timer
		deaggro_timer = 0;

		// Re-aggro should be allowed to attack immediately.
		attack_countdown = 0;

		// Transition to move state (relaxed patrol)
		state = EnemyState.move;
	}
}

function enemy_apocalypse_survivor_state_death(){
	// Enable face flip for death sprites (left-facing, needs flip system)
	face_horizontal_draw_enable = true;

	// Choose death sprite based on posture (kneeling vs standing)
	var _death_sprite = (is_kneeling) ? sprite_death_2 : sprite_death_1;

	// Assign so base death state can detect a death sprite
	sprite_death_left = _death_sprite;
	sprite_death_right = _death_sprite;

	// Ensure sprite is set once (do not loop)
	if(sprite_current != _death_sprite){
		image_system_setup(_death_sprite, ANIMATION_FPS_DEFAULT * animation_fps_multiplier, true, false, 0, IMAGE_LOOP_FULL);
	}

	// Call parent death state for cleanup
	enemy_state_death();
}

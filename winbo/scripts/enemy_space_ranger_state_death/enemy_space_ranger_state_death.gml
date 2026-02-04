function enemy_space_ranger_state_death(){
	// Enable face flip for death sprites (left-facing, needs flip system)
	face_horizontal_draw_enable = true;

	// Choose random death sprite (1 or 2)
	if(sprite_current != sprite_death_1 && sprite_current != sprite_death_2){
		var _death_sprite = choose(sprite_death_1, sprite_death_2);
		image_system_setup(_death_sprite, ANIMATION_FPS_DEFAULT * animation_fps_multiplier, true, false, 0, IMAGE_LOOP_FULL);
	}
	
	// Call parent death state
	enemy_state_death();
}

function enemy_space_ranger_state_idle(){
	// Enable face flip for idle sprite (left-facing, needs flip system)
	face_horizontal_draw_enable = true;

	// Call parent state idle
	enemy_state_idle();
}

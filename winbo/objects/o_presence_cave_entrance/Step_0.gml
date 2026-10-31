if(global.game_state == GameState.play || global.game_state == GameState.dialogue){
	portal_position = (portal_position + portal_animation_fps / SECOND
		* global.delta_time_factor_scaled) mod portal_frame_count;
}

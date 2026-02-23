// NOTE: We intentionally do NOT call event_inherited() here because:
// 1. enemy_space_ranger_gamestate_play() handles all state logic, movement, image, and transform updates
// 2. Calling event_inherited() would run enemy_gamestate_play() FIRST, causing double execution
//    of attack states and double countdown decrements
// Instead, we manually apply the floating effect from o_enemy_ranged_flying_parent:
if (global.game_state == GameState.play) {
	draw_adjustment_x = 0;
	draw_adjustment_y = (global.wave_sine_1_scaled - 0.5) * 50;
}

// Game State Switch - Using Space Ranger specific gamestate
switch(global.game_state){
	case GameState.play:
		enemy_space_ranger_gamestate_play();

		// Interact System
		interact_system_update();
	break;

	case GameState.gameover:
		enemy_gamestate_gameover();
	break;

	case GameState.stop:
	case GameState.menu:
		enemy_gamestate_stop_game();
	break;
}

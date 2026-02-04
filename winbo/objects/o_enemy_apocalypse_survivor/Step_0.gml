// NOTE: We intentionally do NOT call event_inherited() here because:
// 1. enemy_apocalypse_survivor_gamestate_play() handles all state logic, movement, image, and transform updates
// 2. Calling event_inherited() would run enemy_gamestate_play() FIRST, causing double execution
//    of attack states and double countdown decrements

// Game State Switch - Using Apocalypse Survivor specific gamestate
switch(global.game_state){
	case GameState.play:
		enemy_apocalypse_survivor_gamestate_play();

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

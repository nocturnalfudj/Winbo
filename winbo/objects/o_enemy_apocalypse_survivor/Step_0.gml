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
	case GameState.stop:
	case GameState.menu:
		// Keep death/destroy progressing with survivor-specific death handling
		// so fallback draw can render full sprites consistently.
		switch(state){
			case EnemyState.death:
				enemy_apocalypse_survivor_state_death();
			break;
			
			case EnemyState.destroy:
				enemy_state_destroy();
			break;
		}
		
		// Match the base gameover/stop update flow.
		movement_system_update();
		transform_system_update();
	break;
}

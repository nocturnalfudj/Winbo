//Game State Switch
switch(global.game_state){
	case GameState.start:
	break;
	
	case GameState.play:
	case GameState.stop:
		bomb_game_state_play();
	break;
}
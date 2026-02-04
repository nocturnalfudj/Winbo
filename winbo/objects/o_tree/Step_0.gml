//GameState Switch
switch(global.game_state){
	case GameState.play:
		time = (time + 0.3 * 0.02) mod 1;
	break;
}
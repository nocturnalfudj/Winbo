//Inherit Actor
event_inherited();

//Game State Switch
switch(global.game_state){
	case GameState.play:
		bullet_gamestate_play();
	break;
	
	case GameState.stop:
	case GameState.menu:
	case GameState.gameover:
		bullet_gamestate_gameover();
	break;
}
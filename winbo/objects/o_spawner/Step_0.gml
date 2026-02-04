//Inherit
event_inherited();

//Game State Switch
switch(global.game_state){
	case GameState.play:
		spawner_gamestate_play();
	break;
}
//Inherit Actor
event_inherited();

//Game State Switch
switch(global.game_state){
	case GameState.play:
		enemy_gamestate_play();
		
		//Interact System
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
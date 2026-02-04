//Inherit Actor
event_inherited();

//Game State Switch
switch(global.game_state){
	case GameState.play:
		//Transform Update
		transform_system_update();
		
		//Image Update
		image_system_update();
	break;
	
	case GameState.gameover:
		//Transform Update
		transform_system_update();
	break;
	
	case GameState.stop:
	case GameState.menu:
		//Transform Update
		transform_system_update();
	break;
}
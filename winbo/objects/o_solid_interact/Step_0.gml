//Game State Switch
switch(global.game_state){
	case GameState.play:
		switch(state){
			case SolidState.idle:
				//Interact System
				interact_system_update();
			break;
			
			case SolidState.hit:
				flash_alpha = 1;
				state = SolidState.idle;
			break;
		}
	break;
}
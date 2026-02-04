//Game State Switch
switch(global.game_state){
	case GameState.play:
		switch(state){
			case SolidState.idle:
				
			break;
			
			case SolidState.hit:
				flash_alpha = 1;
				state = SolidState.idle;
			break;
		}
	break;
}
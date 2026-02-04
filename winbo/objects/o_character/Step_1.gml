//Inherit Actor
event_inherited();

//Game State Switch
switch(global.game_state){
	case GameState.play:
		//Interact System
		interact_system_update_begin_step();
	break;
}
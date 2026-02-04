/// @description OS Pause Unpause Delay
//OS Not Paused
if(!os_is_paused()){
	if(global.game_state == GameState.os_paused){
		game_state_set_target(os_paused_prev_game_state);
		
		switch(os_paused_prev_game_state){
			case GameState.play:
				//Pause Game
				if(global.game_state != GameState.pause){
					//Pause
					with(o_ui){
						os_paused_pause = true;
					}
				}
			break;
		}
	}
}
else{
	alarm[MasterAlarm.os_pause_delay] = os_paused_unpause_delay;
}
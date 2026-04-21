function master_game_state_gameover() {
	//First Step of this Game State
	if(!global.game_state_one_step_complete){
		//Reset Countdown
		gameover_countdown = gameover_countdown_max;
	}
	
	//Lerp to Slow Motion
	//time_scale = lerp(time_scale,0.1,0.05);
	
	//Countdown
	if(gameover_countdown > 0){
		gameover_countdown -= global.delta_time_factor;
	}
	
	//Countdown Complete
	if(gameover_countdown <= 0){
		// Check for mouse click to continue
		if(mouse_check_button_pressed(mb_left)){
			// Reset Lives
			o_director.resource[Resource.winbo_lives][Team.player] = PLAYER_HP_MAX_DEFAULT;
			
			// Reset Cash
			o_director.resource[Resource.cash][Team.player] = 0;
			
			// Reset Next Level
			o_director.next_level = r_game_level_0;
			
			// Reset level timer
			o_director.level_timer = 0;
			
			director_gameplay_transition_request(
				r_game_level_presence,
				director_gameplay_transition_options_build(
					r_game_level_presence,
					true,
					true,
					false,
					GameState.play,
					PlayerSpawnContext.presence_start
				)
			);
			}
		}
	}

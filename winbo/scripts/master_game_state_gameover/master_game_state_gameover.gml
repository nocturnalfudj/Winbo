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
			o_director.next_level = r_game_level_test;
			
			// Reset level timer
			o_director.level_timer = 0;
			
			// Restore UI anchors before transitioning
			with(o_ui){
				//Add HUD
				ui_anchor_create(o_anchor_hud,"lyr_hud");
			
				//Add Game
				ui_anchor_create(o_anchor_game,"lyr_pfx_midground");
			
				//Remove Gameover
				ui_anchor_remove(o_anchor_gameover);
			}
		
			// Set flag to prevent life deduction on spawn
			o_director.level_transitioning = true;
		
			// Set game state to play directly
			global.game_state = GameState.play;
			global.game_state_target = noone;
		
			// Go back to start room
			room_goto(r_game_level_presence);
		}
	}
}
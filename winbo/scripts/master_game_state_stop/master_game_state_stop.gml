function master_game_state_stop() {
	//Game State Change to Menu After One Step
	if(global.game_state_one_step_complete){
		// Reset bonus room state
		o_director.bonus_room_origin = noone;
		o_director.bonus_room_active = false;
		o_director.bonus_room_entry_x = 0;
		o_director.bonus_room_entry_y = 0;
		
		// Reset level transitioning flag
		o_director.level_transitioning = false;
		
		// Reset level timer
		o_director.level_timer = 0;
		
		// Go to menu room
		room_goto(r_game);
		
		// Change game state to menu
		game_state_set_target(GameState.menu);
		global.game_state = GameState.menu;
	}
}
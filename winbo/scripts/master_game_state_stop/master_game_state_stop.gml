function master_game_state_stop() {
	//Game State Change to Menu After One Step
		if(global.game_state_one_step_complete){
			for(var _i = 0; _i < array_length(gameplay_loading_groups_current); _i++){
				texturegroup_unload_ags(gameplay_loading_groups_current[_i], true);
			}
			gameplay_loading_groups_current = [];
			gameplay_loading_request = noone;
			gameplay_loading_phase = GameplayLoadingPhase.finished;
			master_screen_fade_set_immediate(0);
			gameplay_loading_active = false;
			gc_collect();
			
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

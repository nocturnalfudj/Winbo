//Game State Switch
bg_anim_time_seconds += delta_time / 1000000;

	switch(global.game_state){
		case GameState.start:
			// Startup transitions are orchestrated by o_master while gameplay_loading_active is true.
		break;
	
	case GameState.play:
		#region Player Respawn
			if(instance_number(o_player) <= 0){
				// Check if this is a level transition (don't deduct life)
				if(level_transitioning){
					// Just respawn player without deducting life
					director_spawn_player_all_joined(director_player_spawn_context_for_room_entry(room));
					
					// Reset User Health
					var _hp;
					_hp = PLAYER_HP_MAX_DEFAULT;
					with(o_player){
						hp = _hp;
						with(user){
							hp = _hp;
							alive = true;
						}
					}
					
					// Clear the flag now that player is spawned
					level_transitioning = false;
				}
				// Normal death - deduct life
				else if(resource[Resource.winbo_lives][Team.player] > 1){
					//Deduct a Life
					resource[Resource.winbo_lives][Team.player] -= 1;
					
					//Track death
					level_stat_add(LevelStat.deaths);
					
					//Respawn Player
					director_spawn_player_all_joined();
		
					//Reset User Health
					var _hp;
					_hp = PLAYER_HP_MAX_DEFAULT;
					with(o_player){
						hp = _hp;
						with(user){
							hp = _hp;
							alive = true;
						}
					}
				}
				//No More Lives
				else{
					//Trigger Gameover
					game_state_set_target(GameState.gameover);
					
					//Reset Lives
					//resource[Resource.winbo_lives][Team.player] = PLAYER_LIVES_DEFAULT
					
					//Reset Cash
					//resource[Resource.cash][Team.player] = 0;
					
					//Reset Next Level
					next_level = r_game_level_0;
				}
			}
		#endregion
		
		//Increase Level Timer
		level_timer += global.delta_time_factor / SECOND;
	break;
	
	case GameState.stop:
		with(o_player){
			state = PlayerState.death;
		}
	break;
}

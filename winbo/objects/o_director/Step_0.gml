//Game State Switch
switch(global.game_state){
	case GameState.start:
		if(room != r_game_level_presence){
			room_goto(r_game_level_presence);
		}
		else{
			//Move to Depth Object Instance Layer
			layer = layer_get_id("lyr_depth_object_instances");	//So Drawing Happens on the Correct Layer
		
			//Create Path Finding Grid
			director_room_path_finding_grid_setup();
		
			//Give Lives
			resource[Resource.winbo_lives][Team.player] = PLAYER_HP_MAX_DEFAULT;
		
			#region Players
				o_input.user[0].joined = true;
				director_spawn_player_all_joined();
		
				//Reset User Health
				with(o_player){
					hp = PLAYER_HP_MAX_DEFAULT;
					with(user){
						hp = PLAYER_HP_MAX_DEFAULT;
						alive = true;
					}
				}
			#endregion
			
			// Reset level stats for new level
			level_stat_reset_all();
	
			#region Camera
				//Follow Player
				with(o_camera){
					if(instance_number(o_player) > 0){
						//State to Follow
						state = CameraState.follow;
			
						//Follow Target ID set to player object so that multiplayer works properly
						follow_target_id = o_player;
						
						#region Update Follow Target Difference
							follow_target_difference.x = 0;
							follow_target_difference.y = 0;
						#endregion
						
						follow_method_previous = CameraFollowMethod.lerp_to_targ;
						follow_method = CameraFollowMethod.new_room_snap;
					}
					else{
						//State to Move
						state = CameraState.move;
					}
				}
			#endregion
			
			// Ensure level_transitioning flag is cleared
			level_transitioning = false;
		}
	break;
	
	case GameState.play:
		#region Player Respawn
			if(instance_number(o_player) <= 0){
				// Check if this is a level transition (don't deduct life)
				if(level_transitioning){
					// Just respawn player without deducting life
					director_spawn_player_all_joined();
					
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
					//resource[Resource.winbo_lives][Team.player] = PLAYER_HP_MAX_DEFAULT
					
					//Reset Cash
					//resource[Resource.cash][Team.player] = 0;
					
					//Reset Next Level
					next_level = r_game_level_test;
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
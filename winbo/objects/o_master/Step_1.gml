#region Game State Target
	//Game State Target is NOT Noone
	if(global.game_state_target != noone){
		//Game State Does NOT Equal Target
		if(global.game_state != global.game_state_target){
			//Update Game State to Be Target
			global.game_state = global.game_state_target
		
			//Reset Game State Related Variables
			global.game_state_one_step_complete = false;
		}
		else{
			//Game State One Step Complete
			global.game_state_one_step_complete = true;
		
			//Reset Game State Target
			global.game_state_target = noone;
		}
	}
#endregion

#region Delta Time
	var _delta_time;
	_delta_time = delta_time/1000000;
	
	delta_time_smoothing[delta_time_smoothing_sample_current] = _delta_time;
	delta_time_smoothing_sample_current++;
	if(delta_time_smoothing_sample_current >= DELTA_TIME_SMOOTHING_SAMPLE_SIZE)
		delta_time_smoothing_sample_current = 0;
		
	var _sample_size,_sample_sum;
	_sample_size = 0;
	_sample_sum = 0;
	for(var _i=0;_i<DELTA_TIME_SMOOTHING_SAMPLE_SIZE;_i++){
		if(delta_time_smoothing[_i] != -1){
			_sample_size++;
			_sample_sum += delta_time_smoothing[_i];
		}
	}
	_delta_time = _sample_sum/_sample_size;
	
	global.delta_time = _delta_time;
	_delta_time = SECOND*_delta_time;
	
	//sdm("_delta_time: " + string(_delta_time));
	
	_delta_time = clamp(_delta_time,1,2);
	if(_delta_time < 1.1)
		_delta_time = 1;

	global.delta_time_factor = _delta_time;
	
	global.delta_time_factor_scaled = global.delta_time_factor * time_scale * time_effect_scale;
	current_time_scaled += global.delta_time_factor_scaled;
	
	//Time Scale Target Lerp
	if(time_scale != time_scale_target){
		time_scale = lerp_with_gap_close(time_scale,time_scale_target,time_scale_lerp_val,0.01);
	}
	
	//Time Scale Effect Ease
	if(time_effect_scale_time_current != time_effect_scale_time_max){
		//Run Ease Animation
		time_effect_scale = script_execute(time_effect_scale_ease,time_effect_scale_start,time_effect_scale_target,false,time_effect_scale_time_current,time_effect_scale_time_max);
		
		//Increase Time Current
		time_effect_scale_time_current += _delta_time;
		
		//At or Beyond Max Time
		if(time_effect_scale_time_current >= time_effect_scale_time_max){
			//Finish Time
			time_effect_scale_time_current = time_effect_scale_time_max;
			
			//Set to Target
			time_effect_scale = time_effect_scale_target;
		}
	}
#endregion

#region Tick
	if(tick_countdown_current == 0){
		tick_current++;
		if(tick_current = Tick.SIZE)
			tick_current = Tick.a;
		
		tick_countdown_current = tick_countdown_max;
		global.tick_now = tick_current;
	}
	else{
		if(tick_countdown_current == tick_countdown_max)
			global.tick_now = -1;
		
		tick_countdown_current -= 1;
	}
#endregion

#region FPS Average
	if(BUILD_TYPE_DEV && FPS_AVERAGE_ENABLE){
		fps_average[fps_average_current] = fps_real;
	
		fps_average_current++;
		if(fps_average_current == FPS_AVERAGE_COUNT){
			fps_average_current = 0;
		
			var _av = 0;
			for(var _i=0;_i<FPS_AVERAGE_COUNT;_i++){
				_av += fps_average[_i];
			}
			_av = _av/FPS_AVERAGE_COUNT;
			_av = round(_av);
			sdm("fps_real : " + string(_av));
		}
	}
#endregion

#region Waves
	// some sine wave = a + (1 + sin(2 * pi * time * b)) * c
	// where a is the starting minimum value, b is the speed, and c is the offset to cap the maximum value

	// sine wave examples
	//var t_current_time = current_time / 1000;
	//sine_wave_0 = 0.50 + (1 + sin(2 * pi * t_current_time * 0.30)) * 0.250;   // gives 0.50 to 1.00
	//sine_wave_1 = 0.60 + (1 + sin(2 * pi * t_current_time * 0.30)) * 0.200;   // gives 0.60 to 1.00
	//sine_wave_2 = 0.50 + (1 + sin(2 * pi * t_current_time * 0.30)) * 0.175;   // gives 0.50 to 0.85

	var _time_current;
	_time_current = current_time / 100;
	global.wave_sine_0 = wave_ags(0.5,1,0.3,_time_current);   // gives 0.50 to 1.00
	
	_time_current = current_time_scaled / 10;
	global.wave_sine_0_scaled = wave_ags(0,1,0.3,_time_current);   // gives 0 to 1.00
	global.wave_sine_1_scaled = wave_ags(0,1,0.05,_time_current);   // gives 0 to 1.00
	global.wave_sine_2_scaled = wave_ags(0,1,0.025,_time_current);   // gives 0 to 1.00
	global.wave_sine_3_scaled = wave_ags(0.2,0.9,0.15,_time_current);   // gives 0.2 to 0.9
	global.wave_sine_4_scaled = wave_ags(0.0,0.8,0.1,_time_current);   // gives 0 to 0.8
	global.wave_sine_5_scaled = wave_ags(0.3,1.0,0.15,_time_current);   // gives 0.3 to 1.0
	
	master_wave[MasterWave.sine_0_scaled] = global.wave_sine_0_scaled;
	master_wave[MasterWave.sine_1_scaled] = global.wave_sine_1_scaled;
	master_wave[MasterWave.sine_2_scaled] = global.wave_sine_2_scaled;
	master_wave[MasterWave.sine_3_scaled] = global.wave_sine_3_scaled;
	master_wave[MasterWave.sine_4_scaled] = global.wave_sine_4_scaled;
	master_wave[MasterWave.sine_5_scaled] = global.wave_sine_5_scaled;
#endregion

//Freeze
freeze_countdown.Update();

#region GameState Switch
	switch(global.game_state){
		case GameState.boot:
			master_game_state_boot();
		break;
		
		case GameState.intro:
			master_game_state_intro();
		break;
		
		case GameState.loading_app:
			master_game_state_loading_app();
		break;
		
		case GameState.close:
			//Close Application
			game_end();
		break;
		
		case GameState.menu:
			//OS Paused Check
			master_os_paused_check();
		break;
		
		case GameState.advert:
			#region Advert
				if(advert_active){
					//Run Force Exit Countdown
					advert_force_exit_countdown.Update();
				
					var _advert_force_exit;
					_advert_force_exit = advert_force_exit_countdown.trigger_active;
				
					var _advert_finished;
					_advert_finished = false;
				
					//Advert Finished
					if(_advert_force_exit || _advert_finished){
						game_state_set_target(advert_game_state_prev);
						advert_active = false;

						//Remove Menu
						ui_anchor_remove(o_anchor_advert);
					}
				}
			#endregion
		break;
		
		case GameState.start:
			master_game_state_start();
		break;
		
		case GameState.loading:
		break;
		
		case GameState.pre_game:
		break;
	
		case GameState.play:
			//OS Paused Check
			master_os_paused_check();
		break;
		
		case GameState.gameover:
			master_game_state_gameover();
		break;
		
		case GameState.post_game:
		break;
		
		case GameState.stop:
			master_game_state_stop();
		break;
	
		case GameState.pause:
			//OS Paused Check
			master_os_paused_check();
		break;
	
		case GameState.level_end_flash:
			#region Level End Flash
				// Animate white flash alpha
				level_end_flash_countdown.Update();
			
				// Progress through the flash (0 = start, 1 = end)
				var _progress = 1 - (level_end_flash_countdown.time / level_end_flash_countdown.time_max);
			
				if(_progress < 0.1){
					// Fade in quickly (first 10% of time = 0.15 seconds)
					level_end_flash_alpha = _progress / 0.1;
				}
				else if(_progress < 0.8){
					// Stay at full white (middle 70% of time)
					level_end_flash_alpha = 1;
				}
				else{
					// Fade out (last 20% of time = 0.3 seconds)
					level_end_flash_alpha = 1 - ((_progress - 0.8) / 0.2);
				}
			
				// After countdown, transition to celebration
				if(level_end_flash_countdown.trigger_active){
					game_state_set_target(GameState.level_end_celebration);
				
					// Reset celebration countdown for next use
					level_end_celebration_countdown.Reset();
				}
			#endregion
		break;
	
		case GameState.level_end_celebration:
			#region Level End Celebration
				// Check celebration mode
				var _celebration_finished = false;
			
				if(level_end_celebration_mode == LevelEndCelebrationMode.countdown){
					// Mode 1: Countdown-based (3 seconds)
					level_end_celebration_countdown.Update();
				
					if(level_end_celebration_countdown.trigger_active){
						_celebration_finished = true;
					}
				}
				else if(level_end_celebration_mode == LevelEndCelebrationMode.animation){
					// Mode 2: Animation-based (wait for dance animation to end)
					// Check if level end character's dance animation has finished
					with(o_door){
						if(level_end_character_enable){
							if(level_end_character_state == LevelEndCharacterState.dancing){
								// Check if animation stopped (non-looping dance would set animate to false)
								if(!image.animate){
									_celebration_finished = true;
								}
							}
						}
					}
				}
			
				// When celebration finished, show results
				if(_celebration_finished){
					game_state_set_target(GameState.level_results);
				}
			#endregion
		break;
	
		case GameState.level_results:
			#region Level End Results
				// Calculate score on first frame if not already done
				if(o_director.level_results_score_data == noone){
					o_director.level_results_score_data = level_score_calculate();
				}
			
				// Check for mouse click to continue
				if(mouse_check_button_pressed(mb_left)){
					// Store target room before transition
					with(o_door){
						if(level_end_character_enable && level_end_character_triggered){
							// Determine target room
							if(room == r_game_level_presence){
								o_master.level_end_target_room = o_director.next_level;
							}
							else{
								o_director.next_level = room_target;
								o_master.level_end_target_room = r_game_level_presence;
							}
						}
					}
				
					// Start fade to black
					game_state_set_target(GameState.level_end_fade);
					level_end_fade_countdown.Reset();
				
					// Reset score data for next level
					o_director.level_results_score_data = noone;
				}
			#endregion
		break;

		case GameState.level_end_fade:
			#region Level End Fade
				// Animate fade to black
				level_end_fade_countdown.Update();
		
				var _progress = 1 - (level_end_fade_countdown.time / level_end_fade_countdown.time_max);
				level_end_fade_alpha = _progress; // 0 to 1 over 1 second
		
				// When fade complete, transition to next room
				if(level_end_fade_countdown.trigger_active){
					if(level_end_target_room != noone){
						// Reset level timer
						o_director.level_timer = 0;
			
						// Set flag to prevent life deduction on spawn
						o_director.level_transitioning = true;
			
						// Set game state to play directly (must be immediate for audio system)
						global.game_state = GameState.play;
						global.game_state_target = noone;
			
						// Go to target room
						room_goto(level_end_target_room);
						level_end_target_room = noone;
			
						// Reset fade
						level_end_fade_alpha = 0;
					}
				}
			#endregion
		break;
	}
#endregion

#region Dev Mode
	if(keyboard_check_pressed(vk_f3)){
		//Toggle Dev Mode
		dev_mode = !dev_mode;
		if(dev_mode){
			window_set_cursor(cr_default);
		}
		else{
			window_set_cursor(cr_none);
		}
		
		//Toggle Debug Overlay
		debug_overlay_enable = !debug_overlay_enable;
		
		var _scale;
		if(IS_MOBILE){
			_scale = 2;
		}
		else{
			_scale = 1;
		}
		
		show_debug_overlay(debug_overlay_enable,,_scale);
	}
	
	if(keyboard_check_pressed(vk_f5)){
		//Toggle Dev Mode
		debug_navigation_grid_enable = !debug_navigation_grid_enable;
	}
	
	if(dev_mode){
		//Restart
		if((keyboard_check(vk_lcontrol)) && (keyboard_check_pressed(ord("R")))){
			show_debug_overlay(false);
			game_restart();
		}	
	}
	else{
		if(is_debug_overlay_open()){
			if(!debug_overlay_enable){
				show_debug_overlay(false);
			}
		}
	}
	
	//Mouse For Debug Overlay
	if(is_mouse_over_debug_overlay()){
		window_set_cursor(cr_default);
		//cursor_sprite = -1;
	}
	else{
		if((global.game_state == GameState.play) || (global.game_state == GameState.freeze)){
			window_set_cursor(cr_none);
			cursor_sprite = -1;
		}
		else{
			window_set_cursor(cr_default);
			cursor_sprite = spr_crosshair;
		}
		
		//window_set_cursor(cr_none);
		with(o_input){
			//Gamepad Using
			if(GAMEPAD_ENABLE && !user[0].gamepad_using){
				//cursor_sprite = spr_crosshair;
			}
		}
	}
#endregion
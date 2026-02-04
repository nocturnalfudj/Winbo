#region Build
	#macro NAME				"Winbo"
	#macro VERSION			"0.0.1"//GM_version
	#macro BUILD_TYPE_DEV	true
	#macro SDM_ENABLE		true
	#macro DEBUG_CLEANUP	false
	#macro DEBUG_OVERLAY_ENABLE true
	
	#macro TESTING_MOBILE_ON_DESKTOP true
	
	version_any_run_count = 0;
	version_current_run_count = 0;
#endregion

//Set Window Name
window_set_caption(NAME + " " + VERSION);

//Disable Depth Buffer
if(!IS_BROWSER)
	surface_depth_disable(true);

//Randomise Seed
randomise();

#region Dev
	dev_mode = false;
	debug_overlay_enable = false;
	debug_navigation_grid_enable = false;
	
	#region FPS Average
		#macro FPS_AVERAGE_ENABLE false
		#macro FPS_AVERAGE_COUNT 5
		for(var _i=0;_i<FPS_AVERAGE_COUNT;_i++){
			fps_average[_i] = 0;
		}
		fps_average_current = 0;
	#endregion
	
	#region Developers
		enum Developer{
			callum,
		
			SIZE
		}
	
		developer_name[Developer.callum] = "Callum";
	#endregion
#endregion

#region Global Game States
	global.game_state = GameState.boot;
	global.game_state_target = noone;
	global.game_state_one_step_complete = false;

	enum GameState{
		//Start of App
		boot,
		intro,
		loading_app,
		
		//Minimising
		os_paused,
		
		//Menu
		menu,
		
		advert,
		
		//In Game
		start,
		loading,
		pre_game,
		play,
		play_player_hit,
		dialogue,
		game_menu,
		pause,
		cutscene,
		freeze,
		gameover,
		post_game,
		stop,
	
		//Level End Sequence
		level_end_flash,
		level_end_celebration,
		level_results,
		level_end_fade,
	
		//Closing App
		close,
	
		SIZE
	}

	//OS Paused
	os_paused_prev_game_state = noone;
	os_paused_unpause_delay = 0.5*SECOND;
	
	//Freeze
	freeze_active = false;
	freeze_game_state_prev = -1;
	freeze_time = 0;
	freeze_countdown = new Countdown(1,SECOND * 0.1,true,COUNTDOWN_RESET_COUNT_NEVER,noone);
	
	//Gameover Countdown
	gameover_countdown_max = SECOND * 0.5;
	gameover_countdown = gameover_countdown_max;
#endregion

#region Level End
	// Celebration mode enum
	enum LevelEndCelebrationMode {
		countdown,
		animation
	}
	
	level_end_flash_countdown = new Countdown(1.5*SECOND, 1.5*SECOND, true, COUNTDOWN_RESET_COUNT_NEVER, noone);
	level_end_flash_alpha = 0;
	level_end_celebration_countdown = new Countdown(2*SECOND, 2*SECOND, true, COUNTDOWN_RESET_COUNT_NEVER, noone);
	level_end_celebration_mode = LevelEndCelebrationMode.countdown;
	level_end_fade_alpha = 0;
	level_end_fade_countdown = new Countdown(1*SECOND, 1*SECOND, true, COUNTDOWN_RESET_COUNT_NEVER, noone);
	level_end_target_room = noone; // Store which room to transition to
#endregion

#region Boot
	boot_finished_camera = false;
#endregion

#region Intro
	#macro INTRO_SKIP		false
	#macro INTRO_SKIPPABLE	true
	
	enum IntroStage{
		wait_start,
		fade_in,
		wait_middle,
		fade_out,
		wait_end,
		
		SIZE
	}	
	intro_stage = IntroStage.wait_start;
	
	intro_stage_time[IntroStage.wait_start]		= SECOND *0.5;
	intro_stage_time[IntroStage.fade_in]		= SECOND;
	intro_stage_time[IntroStage.wait_middle]	= SECOND * 0.5;
	intro_stage_time[IntroStage.fade_out]		= SECOND *0.5;
	intro_stage_time[IntroStage.wait_end]		= SECOND *0.5;
	
	intro_time = intro_stage_time[intro_stage];
#endregion

#region Advert
	advert_active = false;
	advert_game_state_prev = -1;
	
	advert_force_exit_countdown = new Countdown(0,SECOND * 60,true,0,noone);
#endregion

#region Alarms
	enum MasterAlarm{
		center_window,
		freeze,
		os_pause_delay,
		network_connection_check
	}
#endregion

#region Internet Connection
	global.network_connected = os_is_network_connected(true);
	alarm[MasterAlarm.network_connection_check] = 10 * SECOND;
#endregion

#region Time
	global.delta_time_factor = 1;
	global.delta_time_factor_scaled = 1;
	
	#macro DELTA_TIME_SMOOTHING_SAMPLE_SIZE 10
	for(var _i=0;_i<DELTA_TIME_SMOOTHING_SAMPLE_SIZE;_i++){
		delta_time_smoothing[_i] = -1;
	}
	delta_time_smoothing_sample_current = 0;
	
	
	time_scale = 1;
	time_scale_target = 1;
	time_scale_lerp_val = 0.2;
	
	time_effect_scale = 1;
	time_effect_scale_start = 1;
	time_effect_scale_target = 1;
	time_effect_scale_ease = ease_expo_in;
	time_effect_scale_time_max = SECOND * 0.2;
	time_effect_scale_time_current = time_effect_scale_time_max;
	
	current_time_scaled = 0;
	
	#macro SECOND 60
	#macro MINUTE 3600
	#macro HOUR 216000
	
	#region Datetime Epoch
		if (date_get_timezone() != timezone_utc)
			date_set_timezone(timezone_utc);

		global.datetime_epoch = date_create_datetime(1970,1,1,0,0,0);
		
		epoch_update();
	#endregion
#endregion

#region Tick
	var _tick_perSecond = 9;
	tick_countdown_max = ceil(SECOND / _tick_perSecond);
	tick_countdown_current = tick_countdown_max;

	enum Tick{
		a,
		b,
		c,
		d,
	
		SIZE
	}
	tick_current = Tick.a;
	global.tick_now = tick_current;
#endregion

#region Waves
	enum MasterWave{
		sine_0_scaled,
		sine_1_scaled,
		sine_2_scaled,
		sine_3_scaled,
		sine_4_scaled,
		sine_5_scaled,
		
		SIZE
	}
	
	for(var _i=0;_i<MasterWave.SIZE;_i++){
		master_wave[_i] = 1;
	}

	//Sine
	global.wave_sine_0 = 1;
	global.wave_sine_0_scaled = 1;
	global.wave_sine_1_scaled = 1;
	global.wave_sine_2_scaled = 1;
	global.wave_sine_3_scaled = 1;
	global.wave_sine_4_scaled = 1;
	global.wave_sine_5_scaled = 1;
#endregion

#region Transform System
	//Setup Update Operation Array
	for(var _i=0;_i<TransformValue.SIZE;_i++){
		global.transform_system_update_operation_array[_i] = 0;
	}
#endregion

#region Transitions
	transition_active = false;
#endregion

#region Platform
	#macro IS_MOBILE false
	#macro android:IS_MOBILE true
	#macro ios:IS_MOBILE true
	
	#macro IS_IOS false
	#macro android:IS_IOS false
	#macro ios:IS_IOS true
	
	#macro IS_ANDROID false
	#macro android:IS_ANDROID true
	#macro ios:IS_ANDROID false
	
	#macro IS_BROWSER (os_browser != browser_not_a_browser)
#endregion

#region Save & Load
	#macro SAVE_REFRESH true			//DANGEROUS - Setting to true will result in all saved data being overwritten with default data
	#macro SAVE_REFRESH_PLAYER true	//DANGEROUS - Setting to true will result in all saved player data being overwritten with default data
	#macro SAVE_REFRESH_SETTINGS true	//DANGEROUS - Setting to true will result in all saved settings data being overwritten with default data
	
	#macro SAVE_FILE_MASTER "master.save"
	//save_map = ds_map_secure_load(SAVE_FILE_MASTER);
	save_map = load_json(SAVE_FILE_MASTER);
	
	bad_load = false;
	bad_load_string = "Master BAD LOAD: ";
	
	if(save_map == -1){
		save_map = ds_map_create();
			
		master_save();
	}
	else{
		master_load();
	}
	
	sdm("");
	sdm("Version Any Run Count: " + string(version_any_run_count));
	sdm("Version Current Run Count: " + string(version_current_run_count));
	sdm("");
#endregion

//Font
draw_set_font(fnt_bahnschrift_16);

//Remove Sprite
sprite_index = noone;
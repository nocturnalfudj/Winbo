#region Path Finding
	#macro CELL_WIDTH 256
	#macro CELL_HEIGHT 128
	global.path_finding_grid = noone;
	global.path_finding_path = path_add();
	
	perlin_noise = new FastNoiseLite(random(4_294_967_295));
#endregion

#region Level
	//Spaces
	level_space_count = 0;
	level_space_active[0] = false;
	
	//Timer
	level_timer = 0;
	
	//Level Stats Tracking
	enum LevelStat {
		orbs_collected,
		lives_collected,
		talismans_collected,
		enemies_defeated_melee,
		enemies_defeated_ranged,
		enemies_defeated_flying,
		hits_taken,
		deaths,
		
		SIZE
	}
	
	// Initialize all stats to 0
	for(var _i = 0; _i < LevelStat.SIZE; _i++){
		level_stats[_i] = 0;
	}
	
	// Scoring configuration - easily tweakable
	level_score_config = {
		// Points per collectible
		points_per_orb: 1,
		points_per_life: 1,
		points_per_talisman: 5,
		
		// Points per enemy type
		points_per_melee_enemy: 2,
		points_per_ranged_enemy: 3,
		points_per_flying_enemy: 4,
		
		// Damage taken thresholds [hits, points]
		damage_thresholds: [
			{hits: 0, points: 50},
			{hits: 1, points: 10},
			{hits: 2, points: 5},
			{hits: 3, points: 1},
			{hits: 4, points: 0}  // 4+ hits = 0 points
		],
		
		// Death thresholds [deaths, points]
		death_thresholds: [
			{deaths: 0, points: 25},
			{deaths: 1, points: 5},
			{deaths: 2, points: 1},
			{deaths: 3, points: 0}  // 3+ deaths = 0 points
		],
		
		// Time penalty config
		time_penalty_start_seconds: 300,  // 5 minutes
		time_penalty_per_second: 1
	};
	
	// Level results score data
	level_results_score_data = noone;
#endregion

#region Talismans
	//Setup All Talismans
	talisman_count = 14;
	for(var _i=0;_i<talisman_count;_i++){
		talisman_found[_i] = false;
		
		talisman_sprite[_i] = asset_get_index("spr_talisman_" + string(_i));
	}
#endregion

#region Interact System
	enum InteractToggleGroup{
		
		SIZE
	}
	
	interact_toggle_group_space_interaction_list = noone;
	for(var _i=0;_i<InteractToggleGroup.SIZE;_i++){
		interact_toggle_group_space_interaction_list[_i] = ds_list_create();
	}
#endregion

#region Teams
	enum Team{
		//Used for Singleplayer and Coop
		player,
		
		//Used for Multiplayer Versus Only
		player_group_a,
		player_group_b,
		
		//EVERYTHING ELSE IS NON PLAYER TEAMS
		
		//NPCs
		npc,
		
		//Enemies
		enemy,
	
		SIZE
	}
#endregion

#region Multiplayer
	//enum MultiplayerMode{
	//	coop,
	//	versus,
		
	//	SIZE
	//}
	
	//multiplayer_mode = MultiplayerMode.coop;
	
	//multiplayer_mode_name[MultiplayerMode.coop] = "Coop";
	//multiplayer_mode_name[MultiplayerMode.versus] = "Versus";
#endregion

#region Environment
	enum Environment{
		default_environment,
		level_1_environment,
		level_2_environment,
		
		SIZE
	}
	
	environment_current = Environment.default_environment;
	environment_foreground_sprite = noone;
	#macro ENVIRONMENT_FOREGROUND_ALPHA 0.5
	
	director_environment_data_setup();
#endregion

#region Depth Draw
	enum DepthObjectLayer{
		ground,
		bottom,
		middle,
		top,
	
		SIZE
	}
	
	enum DepthGrid{
		instance,
		y
	}
	
	for(var _i=0;_i<DepthObjectLayer.SIZE;_i++){
		depth_object_layer_instance_count[_i] = 0;
		depth_grid[_i] = ds_grid_create(2,1);
		depth_grid_height[_i] = 0;
		depth_grid_row[_i] = 0;
	}
	
	depth_grid_draw_event_state = 0;
#endregion

#region Resource
	enum Resource{
		cash,
		premium_cash,
		
		winbo_lives,
		
		SIZE
	}
	
	//Init Resources for Each Team
	for(var _i=0;_i<Resource.SIZE;_i++){
		for(var _j=0;_j<Team.npc;_j++){
			resource[_i][_j] = 0;
		}
	}
	
	//Sale
	shop_sale_active = false;
	#macro SHOP_SALE_DISCOUNT 0.1
#endregion

#region XP
	//Value
	xp = 0;
	
	//Levels
	xp_level = 0;
	xp_level_cost_base = 100;		//Initial XP Cost to get to Level 1
	xp_level_cost_factor = 2;		//How Much XP Cost Increases to get to Next Level
	
	xp_level_cost_previous = (xp_level > 0)? xp_level_cost_base * power(xp_level_cost_factor,xp_level-1) : 0;
	xp_level_cost_next = xp_level_cost_base * power(xp_level_cost_factor,xp_level);
#endregion

#region Custom Sprite System
	// Map to store loaded custom sprites (original_sprite -> custom_sprite)
	custom_sprite_map = ds_map_create();
	
	// Base folder for custom sprites (in included datafiles)
	custom_sprite_folder = "sprites/";
	
	// Define sprite mappings (original sprite -> filename)
	custom_sprite_files = ds_map_create();
	ds_map_add(custom_sprite_files, spr_player_idle, "player.png");
	ds_map_add(custom_sprite_files, spr_platform, "platform.png");
	ds_map_add(custom_sprite_files, spr_platform_moving_green_solo, "platform_moving.png");
	ds_map_add(custom_sprite_files, spr_platform_crumble, "platform_crumble.png");
	ds_map_add(custom_sprite_files, spr_platform_thin_orange, "platform_thin.png");
	//ds_map_add(custom_sprite_files, spr_spikes, "spikes.png");
	//ds_map_add(custom_sprite_files, spr_spring, "spring.png");
	//ds_map_add(custom_sprite_files, spr_orb, "orb.png");
	ds_map_add(custom_sprite_files, spr_door, "door.png");
#endregion

//Status Effects
status_effect_system_data_setup();

#region Levels
	//Next Level
	next_level = r_game_level_0;	//This is the FIRST level after the presence level
	
	// Flag to prevent life deduction during level transitions
	level_transitioning = false;
	
	// Initialize level select system
	level_select_init();
#endregion

#region Bonus Room System
	// Tracks the main level room before entering a bonus room (for return transitions)
	bonus_room_origin = noone;
	
	// Flag indicating player is currently in a bonus room
	bonus_room_active = false;
	
	// Stores player position when entering bonus room (for return spawn)
	bonus_room_entry_x = 0;
	bonus_room_entry_y = 0;
#endregion

#macro ANIMATION_FPS_DEFAULT 15

#region Level Background Animation
	bg_anim_time_seconds = 0;
#endregion

#region Menu Background Shader
	// Shader uniforms
	menu_bg_shader_uniform_time = shader_get_uniform(sh_menu_background, "u_time");
	menu_bg_shader_uniform_gradient_start = shader_get_uniform(sh_menu_background, "u_gradient_start");
	menu_bg_shader_uniform_gradient_mid = shader_get_uniform(sh_menu_background, "u_gradient_mid");
	menu_bg_shader_uniform_gradient_end = shader_get_uniform(sh_menu_background, "u_gradient_end");
	menu_bg_shader_uniform_accent_primary = shader_get_uniform(sh_menu_background, "u_accent_primary");
	menu_bg_shader_uniform_accent_secondary = shader_get_uniform(sh_menu_background, "u_accent_secondary");
	menu_bg_time = 0;
	
	// Menu background colors (RGB values 0-1)
	#macro MENU_BG_GRADIENT_START_R 1.0
	#macro MENU_BG_GRADIENT_START_G 0.9
	#macro MENU_BG_GRADIENT_START_B 0.2
	
	#macro MENU_BG_GRADIENT_MID_R 1.0
	#macro MENU_BG_GRADIENT_MID_G 0.75
	#macro MENU_BG_GRADIENT_MID_B 0.25
	
	#macro MENU_BG_GRADIENT_END_R 0.95
	#macro MENU_BG_GRADIENT_END_G 0.35
	#macro MENU_BG_GRADIENT_END_B 0.1
	
	#macro MENU_BG_ACCENT_PRIMARY_R 1.0
	#macro MENU_BG_ACCENT_PRIMARY_G 0.5
	#macro MENU_BG_ACCENT_PRIMARY_B 0.15
	
	#macro MENU_BG_ACCENT_SECONDARY_R 1.0
	#macro MENU_BG_ACCENT_SECONDARY_G 0.4
	#macro MENU_BG_ACCENT_SECONDARY_B 0.25
#endregion

#region Save & Load
	#macro SAVE_FILE_DIRECTOR "director.save"
	//save_map = ds_map_secure_load(SAVE_FILE_DIRECTOR);
	save_map = load_json(SAVE_FILE_DIRECTOR);
	
	bad_load = false;
	bad_load_string = "Director BAD LOAD: ";
	
	if(save_map == -1 || SAVE_REFRESH || SAVE_REFRESH_PLAYER){
		save_map = ds_map_create();
		//director_save();
	}
	else{
		//director_load();
	}
#endregion

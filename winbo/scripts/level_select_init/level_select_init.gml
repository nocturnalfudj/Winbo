/// @function level_select_init
/// @summary Initialize the level registry and register all available levels.
/// @description Call this once during director creation.
/// @returns {void}
function level_select_init() {
	// Create the level registry map (id -> LevelData)
	o_director.level_registry = ds_map_create();
	
	// Create ordered list of level IDs for the level select menu
	o_director.level_order = ds_list_create();
	
	// Register all game levels
	// Format:
	// level_select_register(id, room, display_name, menu_order, next_level_id, transition_style, start_unlocked, environment_id, load_groups)
	
		level_select_register(
			"opening_cutscene",
			r_opening_cutscene,
			"Opening Cutscene",
		0,
			"tutorial",
			LEVEL_SELECT_TRANSITION_DIRECT,
			true,
			Environment.opening_cutscene_environment,
			["game","opening_cutscene"]
		);
		level_select_register(
			"tutorial",
			r_tutorial,
		"Tutorial",
		1,
		"level_0",
			LEVEL_SELECT_TRANSITION_VIA_PRESENCE_HUB,
			false,
			Environment.tutorial_environment,
			["game","tutorial"]
		);
		level_select_register(
			"presence",
			r_game_level_presence,
		"Presence",
		2,
		"level_0",
			LEVEL_SELECT_TRANSITION_VIA_PRESENCE_HUB,
			false,
			Environment.presence_environment,
			["game","presence","bayhorn","presence_dialogue"]
		);
	
	// Progression uses 0-based asset IDs and 1-based player labels
	level_select_register(
		"level_0",
		r_game_level_0,
		"Level 1",
		3,
			"level_1",
			LEVEL_SELECT_TRANSITION_VIA_PRESENCE_HUB,
			false,
			Environment.level_1_environment,
			["game","level_1","bayhorn","enemies"]
		);
		level_select_register(
			"level_1",
			r_game_level_1,
		"Level 2",
		4,
			"level_0",
			LEVEL_SELECT_TRANSITION_VIA_PRESENCE_HUB,
			false,
			Environment.level_2_environment,
			["game","level_2"]
		);
		level_select_register(
			"asset_test",
			r_game_level_assets_test,
			"Asset Test",
			90,
			"level_0",
			LEVEL_SELECT_TRANSITION_DIRECT,
			true,
			Environment.level_1_environment,
			["game","level_1","level_2","bonus","presence","bayhorn","presence_dialogue","enemies"]
		);
	
	// Bonus rooms are selectable from menus but kept off the main progression chain.
	level_select_register(
		"level_0_bonus_a",
		r_game_level_0_bonus_a,
		"Level 1 - Bonus A",
		10,
			"level_0",
			LEVEL_SELECT_TRANSITION_DIRECT,
			false,
			Environment.bonus_room_environment,
			["game","bonus"]
		);
		level_select_register(
			"level_0_bonus_b",
			r_game_level_0_bonus_b,
		"Level 1 - Bonus B",
		11,
			"level_0",
			LEVEL_SELECT_TRANSITION_DIRECT,
			false,
			Environment.bonus_room_environment,
			["game","bonus"]
		);
		level_select_register(
			"level_1_bonus_a",
			r_game_level_1_bonus_a,
		"Level 2 - Bonus A",
		20,
			"level_1",
			LEVEL_SELECT_TRANSITION_DIRECT,
			false,
			Environment.bonus_room_environment,
			["game","bonus"]
		);
		level_select_register(
			"level_1_bonus_b",
			r_game_level_1_bonus_b,
		"Level 2 - Bonus B",
		21,
			"level_1",
			LEVEL_SELECT_TRANSITION_DIRECT,
			false,
			Environment.bonus_room_environment,
			["game","bonus"]
		);
	
	sdm("Level Select System initialized with " + string(ds_map_size(o_director.level_registry)) + " levels", LOG_COLOUR_COMMAND_SUCCESS);
}

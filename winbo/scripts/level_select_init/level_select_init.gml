/// @function level_select_init
/// @summary Initialize the level registry and register all available levels.
/// @description Call this once during director creation.
/// @returns {void}
function level_select_init() {
	// Create the level registry map (id -> LevelData)
	o_director.level_registry = ds_map_create();
	
	// Create ordered list of level IDs for sequence navigation
	o_director.level_order = ds_list_create();
	
	// Register all game levels
	// Format: level_select_register(id, room, display_name, order)
	
	level_select_register("presence", r_game_level_presence, "Presence", 0);
	
	// Progression uses 0-based asset IDs and 1-based player labels
	level_select_register("level_0", r_game_level_0, "Level 1", 1);
	level_select_register("level_1", r_game_level_1, "Level 2", 2);
	
	// Bonus rooms are selectable from menus but kept off the main progression chain.
	// Mainline progression remains: level_0 -> level_1.
	level_select_register("level_0_bonus_a", r_game_level_0_bonus_a, "Level 1 - Bonus A", 10);
	level_select_register("level_0_bonus_b", r_game_level_0_bonus_b, "Level 1 - Bonus B", 11);
	level_select_register("level_1_bonus_a", r_game_level_1_bonus_a, "Level 2 - Bonus A", 20);
	level_select_register("level_1_bonus_b", r_game_level_1_bonus_b, "Level 2 - Bonus B", 21);
	
	sdm("Level Select System initialized with " + string(ds_map_size(o_director.level_registry)) + " levels", LOG_COLOUR_COMMAND_SUCCESS);
}

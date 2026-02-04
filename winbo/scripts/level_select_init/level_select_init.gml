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
	
	// Test Level + Bonus Rooms
	level_select_register("level_test", r_game_level_test, "Test Level", 1);
	level_select_register("level_test_bonus_a", r_game_level_test_bonus_a, "Test Bonus A", 2);
	level_select_register("level_test_bonus_b", r_game_level_test_bonus_b, "Test Bonus B", 3);
	
	// Level 1 + Bonus Rooms
	level_select_register("level_0", r_game_level_0, "Level 1", 4);
	level_select_register("level_0_bonus_a", r_game_level_0_bonus_a, "L1 Bonus A", 5);
	level_select_register("level_0_bonus_b", r_game_level_0_bonus_b, "L1 Bonus B", 6);
	
	// Level 2 + Bonus Rooms
	level_select_register("level_1", r_game_level_1, "Level 2", 7);
	level_select_register("level_1_bonus_a", r_game_level_1_bonus_a, "L2 Bonus A", 8);
	level_select_register("level_1_bonus_b", r_game_level_1_bonus_b, "L2 Bonus B", 9);
	
	// Level 3 + Bonus Rooms
	level_select_register("level_2", r_game_level_2, "Level 3", 10);
	level_select_register("level_2_bonus_a", r_game_level_2_bonus_a, "L3 Bonus A", 11);
	level_select_register("level_2_bonus_b", r_game_level_2_bonus_b, "L3 Bonus B", 12);
	
	sdm("Level Select System initialized with " + string(ds_map_size(o_director.level_registry)) + " levels", LOG_COLOUR_COMMAND_SUCCESS);
}

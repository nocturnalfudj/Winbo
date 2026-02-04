/// @function master_game_state_start
/// @summary Transition from the boot state into gameplay.
/// @returns {void}
function master_game_state_start() {
	//Game State Change to Player After Changed Room and Spawned Player
	if((room == r_game_level_presence) && (instance_exists(o_player))){
		//Set Target & Immediately Change to Target Game State to avoid 2 steps in Game State Play
		game_state_set_target(GameState.play);
		global.game_state = GameState.play;
	}
}
/// @function master_game_state_boot
/// @summary Boot state handling before entering the main menu.
/// @returns {void}
function master_game_state_boot() {
	//Check All Boot Prep Is Finished
	//Default to Finished
	var _boot_finished;
	_boot_finished = true;
	
	//Check Camera is Finished with Boot
	if(boot_finished_camera == false)
		_boot_finished = false;
	
	//If Finished with Boot
	if(_boot_finished){
		if(INTRO_SKIP){
			//Go to Game Room
			room_goto(r_loading_app);

			//Game State to Loading App
			game_state_set_target(GameState.loading_app);
		
		}
		else{
			//Go to Intro Room
			room_goto(r_intro);

			//Game State to Intro
			game_state_set_target(GameState.intro);
		}
	}
}
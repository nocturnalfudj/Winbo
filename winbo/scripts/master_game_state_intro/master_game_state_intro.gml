function master_game_state_intro() {
	var _intro_finished;
	_intro_finished = false;
	
	#region Intro Stage
		if(intro_time > 0){
			intro_time -= global.delta_time_factor;
		}
		else{
			if(intro_stage < IntroStage.SIZE-1){
				intro_stage++;
				intro_time = intro_stage_time[intro_stage];
			}
			else{
				//Finished with Game State
				_intro_finished = true;
			}
		}
	#endregion

	if((INTRO_SKIPPABLE) && (keyboard_check_pressed(vk_anykey) || mouse_check_button(mb_any) || gamepad_button_check(global.gamepad_device_ui_control,gp_face1))){
		//Finished with Game State
		_intro_finished = true;
	}

	//Finished with Current State
	if(_intro_finished){
		//Go to Game Room
		room_goto(r_loading_app);

		//Game State to Loading App
		game_state_set_target(GameState.loading_app);
	}
}
/// @function player_gamestate_stop_game
/// @summary Handle player destruction when the game ends.
function player_gamestate_stop_game(){
	//State Switch
	switch(state){
		case PlayerState.death:
			//Destroy Torch Light
			with(torch_light){
				//Destroy Instance
				instance_destroy();
			}
		
			//Set to Not Alive
			user.alive = false;
			
			//Shrink & Fade
			transform_animate_from_current_shrink_and_fade();
		
			//State to Destroy
			state = PlayerState.destroy;
		break;
	
		case PlayerState.destroy:
			player_state_destroy();
		break;
	}

	//Movement Update
	//movement_system_update();

	//Transform Update
	transform_system_update();

	//Image Update
	image_system_update();
}
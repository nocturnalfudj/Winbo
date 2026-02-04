/// @function player_gamestate_gameover
/// @summary Handle player logic while in the game over state.
function player_gamestate_gameover(){
	//State Switch
	switch(state){
		case PlayerState.death:
			//If Currently Alive
			if(user.alive){
				//Trigger Death PFX
				//pfx_trigger(PFXPlayer.death);
	
				//Destroy Torch Light
				with(torch_light){
					//Destroy Instance
					instance_destroy();
				}
		
				//Set to Not Alive
				user.alive = false;	
			}
		break;
	
		case PlayerState.destroy:
			player_state_destroy();
		break;
	}

	//Movement Update
	movement_system_update();

	//Transform Update
	transform_system_update();

	//Image Update
	image_system_update();
}
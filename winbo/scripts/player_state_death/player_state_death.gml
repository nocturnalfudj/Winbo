/// @function player_state_death
/// @summary Handle the player's death sequence.
/// @returns {void} No return value.
function player_state_death(){
	if(sprite_current != sprite_death){
		image_system_setup(sprite_death,ANIMATION_FPS_DEFAULT,true,false,0,IMAGE_LOOP_FULL);
	}
	
	//Destroy Torch Light
	with(torch_light){
		//Destroy Instance
		instance_destroy();
	}
	
	//Set to Not Alive
	with(user){
		alive = false;
	}
		
	//State to Destroy
	state = PlayerState.destroy;
}
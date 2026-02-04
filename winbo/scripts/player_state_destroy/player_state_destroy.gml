function player_state_destroy(){
	if(sprite_current_frame >= (image.sprite_number - 1)){
		instance_destroy();
	}
}
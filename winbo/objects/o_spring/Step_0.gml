//Inherit Actor
event_inherited();

//Game State Switch
switch(global.game_state){
	case GameState.play:
		//Transform Update
		//transform_system_update();
		
		//Image Update
		image_system_update();
		
		//End of Active Animation
		if((sprite_current == sprite_active) && (sprite_current_frame == (image.sprite_number - 1))){
			//Back to Idle Sprite
			image_system_setup(sprite_idle,ANIMATION_FPS_DEFAULT,true,true,0,IMAGE_LOOP_FULL);
		}
	break;
	
	case GameState.gameover:
		//Transform Update
		//transform_system_update();
	break;
	
	case GameState.stop:
	case GameState.menu:
		//Transform Update
		//transform_system_update();
	break;
}
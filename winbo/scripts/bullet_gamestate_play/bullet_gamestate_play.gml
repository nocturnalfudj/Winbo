function bullet_gamestate_play(){
	//State Switch
	switch(state){
		case BulletState.create:
			bullet_state_create();
		break;
	
		case BulletState.move:
			bullet_state_move();
		break;
		
		case BulletState.hit:
			bullet_state_hit();
		break;
	
		case BulletState.death:
			bullet_state_death();
		break;
	
		case BulletState.destroy:
			bullet_state_destroy();
		break;
	}

	//Transform Update
	transform_system_update();
	
	//Image Update
	image_system_update();
	
	//PFX Execute
	//pfx_system_execute();
}

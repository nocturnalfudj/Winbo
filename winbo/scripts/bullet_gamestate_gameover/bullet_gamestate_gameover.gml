function bullet_gamestate_gameover(){
	//State Switch
	switch(state){
		case BulletState.death:
			bullet_state_death();
		break;
	
		case BulletState.destroy:
			bullet_state_destroy();
		break;
	}

	//Transform Update
	transform_system_update();
}
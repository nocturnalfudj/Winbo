function enemy_state_destroy(){
	//Destroy instance when Transform is at rest
	transform_updated_check();
	
	if(!transform_updated){
		instance_destroy();
	}
}
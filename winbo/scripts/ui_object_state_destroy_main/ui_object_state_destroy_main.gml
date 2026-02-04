function ui_object_state_destroy_main() {
	//Destroy instance when Transform is at rest
	transform_updated_check();
	
	if(!transform_updated){	
		instance_destroy();
	}
}
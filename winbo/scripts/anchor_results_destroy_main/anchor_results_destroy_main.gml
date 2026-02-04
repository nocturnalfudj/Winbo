function anchor_results_destroy_main(){
	//Destroy instance when Transform is at rest
	transform_updated_check();
	
	if(!transform_updated){
		//Destroy UI Group
		ui_group_set_state(UIGroup.results,UIState.destroy);
		
		//Destroy Instance
		instance_destroy();
	}
}
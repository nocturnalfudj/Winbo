/// @function anchor_persistent_destroy_main
/// @summary Destroy persistent anchor objects when no longer needed.
function anchor_persistent_destroy_main(){
	//Destroy instance when Transform is at rest
	transform_updated_check();
	
	if(!transform_updated){
		//Destroy UI Group
		ui_group_set_state(UIGroup.persistent,UIState.destroy);
		
		//Destroy Instance
		instance_destroy();
	}
}
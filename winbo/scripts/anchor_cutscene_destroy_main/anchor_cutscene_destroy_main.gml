/// @function anchor_cutscene_destroy_main
/// @summary Clean up cutscene UI anchors after movement stops.
function anchor_cutscene_destroy_main(){
	//Destroy instance when Transform is at rest
	transform_updated_check();
	
	if(!transform_updated){
		//Destroy UI Group
		ui_group_set_state(UIGroup.cutscene,UIState.destroy);
		
		//Destroy Instance
		instance_destroy();
	}
}
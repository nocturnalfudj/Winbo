/// @function anchor_menu_destroy_main
/// @summary Clean up the menu anchor when its transform settles.
function anchor_menu_destroy_main(){
	//Destroy instance when Transform is at rest
	transform_updated_check();
	
	if(!transform_updated){
		//Destroy UI Group
		ui_group_set_state(UIGroup.menu,UIState.destroy);
		
		//Destroy Instance
		instance_destroy();
	}
}
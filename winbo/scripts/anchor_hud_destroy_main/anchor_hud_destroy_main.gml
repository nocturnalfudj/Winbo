/// @function anchor_hud_destroy_main
/// @summary Remove the HUD anchor when it has completed its exit.
function anchor_hud_destroy_main(){
	//Destroy instance when Transform is at rest
	transform_updated_check();
	
	if(!transform_updated){
		//Destroy UI Group
		ui_group_set_state(UIGroup.hud,UIState.destroy);
		
		//Destroy Instance
		instance_destroy();
	}
}
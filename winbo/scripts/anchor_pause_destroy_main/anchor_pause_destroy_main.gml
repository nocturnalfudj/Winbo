/// @function anchor_pause_destroy_main
/// @summary Destroy the pause UI once its transform stops moving.
function anchor_pause_destroy_main(){
	//Destroy instance when Transform is at rest
	transform_updated_check();
	
	if(!transform_updated){
		//Destroy UI Group
		ui_group_set_state(UIGroup.pause,UIState.destroy);
		
		//Destroy Instance
		instance_destroy();
	}
}
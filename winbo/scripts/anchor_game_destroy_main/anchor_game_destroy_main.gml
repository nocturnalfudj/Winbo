/// @function anchor_game_destroy_main
/// @summary Destroy a UI anchor once its transform stops updating.
function anchor_game_destroy_main(){
	//Destroy instance when Transform is at rest
	transform_updated_check();
	
	if(!transform_updated){
		//Destroy UI Group
		ui_group_set_state(UIGroup.game,UIState.destroy);
		
		//Destroy Instance
		instance_destroy();
	}
}
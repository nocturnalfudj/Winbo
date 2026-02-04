/// @function anchor_advert_destroy_main
/// @summary Destroy the advert anchor when its transform stops updating.
function anchor_advert_destroy_main(){
	//Destroy instance when Transform is at rest
	transform_updated_check();
	
	if(!transform_updated){
		//Destroy UI Group
		ui_group_set_state(UIGroup.advert,UIState.destroy);
		
		//Destroy Instance
		instance_destroy();
	}
}
/// @function tab_destroy_main
/// @summary Destroy a tab instance once its animations are complete.
/// @returns {void} No return value.
function tab_destroy_main(){
	//Destroy instance when Transform is at rest
	transform_updated_check();
	
	//Check Scroll
	var _scroll_transform_updated;
	_scroll_transform_updated = false;
	with(scroll){
		_scroll_transform_updated = transform_updated_check();
	}
	
	if(!transform_updated && !_scroll_transform_updated){
		//Destroy UI Group
		ui_group_set_state(tab.ui_group,UIState.destroy);
		
		//Destroy Instance
		instance_destroy();
	}
}
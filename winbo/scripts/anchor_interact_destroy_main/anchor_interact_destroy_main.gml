function anchor_interact_destroy_main(){
	//Destroy instance when Transform is at rest
	transform_updated_check();
	
	if(!transform_updated){
		var _list_size;
		_list_size = ds_list_size(interact_ui_children);
		for(var _i=0;_i<_list_size;_i++){
			with(interact_ui_children[| _i]){
				//State to Destroy
				ui_object_state_set(UIState.destroy);
			}
		}
		
		//Destroy Instance
		instance_destroy();
	}
}
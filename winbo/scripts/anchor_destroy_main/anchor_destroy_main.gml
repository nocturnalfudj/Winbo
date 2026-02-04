/// @function anchor_destroy_main
/// @summary Remove an anchor instance after its transform settles.
function anchor_destroy_main(){
	//Destroy instance when Transform is at rest
	transform_updated_check();
	
	//Check Scroll
	var _scroll_transform_updated;
	_scroll_transform_updated = false;
	with(scroll){
		_scroll_transform_updated = transform_updated_check();
	}
	
	if(!transform_updated && !_scroll_transform_updated){
		//Destroy Instance
		instance_destroy();
	}
}
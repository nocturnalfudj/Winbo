function texturegroup_load_ags(_texture_group,_finished_loading){
	//Assume Loading can Default to True if Not Specified
	_finished_loading ??= true;
	
	//Make Sure Texture Group is a String
	_texture_group = string(_texture_group);
		
	//Get Status
	var _texture_group_status;
	_texture_group_status = texturegroup_get_status(_texture_group);
	
	//Needs Loading
	if(_texture_group_status == texturegroup_status_unloaded){
		//Not Finished Loading
		_finished_loading = false;
		
		//Load
		texturegroup_load(_texture_group);
			
		//sdm("texture status - " + _texture_group + " : " +string(texturegroup_get_status(_texture_group)));
	}
	//Still Loading
	else if(_texture_group_status == texturegroup_status_loading){
		//Not Finished Loading
		_finished_loading = false;
			
		//sdm("texture status - " + _texture_group + " : " +string(texturegroup_get_status(_texture_group)));
	}
	//Finished Loading
	else if(_texture_group_status == texturegroup_status_loaded){
		//Fetch
		//texture_prefetch(_texture_group);
			
		//sdm("texture status - " + _texture_group + " : " +string(texturegroup_get_status(_texture_group)));
	}
	
	return _finished_loading;
}
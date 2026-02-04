/// @function texturegroup_unload_ags
/// @summary Flush and unload a texture group if it is currently loaded.
/// @param {string} _texture_group - Name of the texture group to unload.
/// @param {bool} [_finished_loading=true] - Outputs whether unloading finished.
function texturegroup_unload_ags(_texture_group,_finished_loading){
	//Assume Loading can Default to True if Not Specified
	_finished_loading ??= true;
	
	//Make Sure Texture Group is a String
	_texture_group = string(_texture_group);
		
	//Get Status
	var _texture_group_status;
	_texture_group_status = texturegroup_get_status(_texture_group);

	if(_texture_group_status == texturegroup_status_loaded){
		//Not Finished Loading
		_finished_loading = false;
		
		texture_flush(_texture_group);
		texturegroup_unload(_texture_group);
		//sdm("texture status - " + _texture_group + " : " +string(texturegroup_get_status(_texture_group)));
	}
	
	return _finished_loading;
}
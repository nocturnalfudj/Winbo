/// @function text_grid_string_get
/// @summary Return a localized string from the text grid.
/// @param group  Index of the grid group.
/// @param id     Row index within the group.
/// @param langCol Language column to read from.
function text_grid_string_get(_group,_id,_language) {
	if(is_undefined(_language))
		_language = 1;

	var _grid,_string;
	_string = undefined;
	with(o_text){
		_grid = text_grid[_group];

		if(_id < ds_grid_height(_grid)){
			_string = _grid[# _language,_id];
		}
		else{
			_string = undefined;
		}
	}

	return _string;
}
///@param text_group
///@param language
function text_language_column_get(_text_group,_language) {
	//Get Text Grid and Width
	var _text_grid,_text_grid_width,_language_column;
	_text_grid = o_text.text_grid[_text_group];
	_text_grid_width = ds_grid_width(_text_grid);

	//Default to Language Not Found
	_language_column = -1;

	//Search Text Grid for Matching Language
	for(var _i=1;_i<_text_grid_width;_i++){
		if(_language == _text_grid[# _i, TextRow.language]){
			_language_column = _i;
		}
	}
	
	return _language_column;
}
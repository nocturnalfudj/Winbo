function text_language_swap() {
	//Set New Language
	var _language_column;
	_language_column = -1;

	var _text_grid,_text_grid_width,_text_grid_h;
	var _text_list,_text_list_size;
	var _text,_text_id,_text_value_new;
	
	//Loop through all Text Groups
	for(var _i=0;_i<TextGroup.SIZE;_i++){
		//Find the New Language Column in the Text Group Grid
		_language_column = text_language_column_get(_i,language_new);
	
		//If New Language Column was found
		if(_language_column!=-1){
			//Copy Contents of New Language Column to the Active Column in the Text Grid
			_text_grid = text_grid[_i];
			_text_grid_width = ds_grid_width(_text_grid);
			_text_grid_h = ds_grid_height(_text_grid);
			ds_grid_set_grid_region(_text_grid,_text_grid,_language_column,0,_language_column,_text_grid_h,1,0);
		
		
			//Update the Strings in all Text Arrays
			_text_list = text_list[_i];
			_text_list_size = ds_list_size(_text_list);
			for(var _j=0;_j<_text_list_size;_j++){
				_text = _text_list[| _j];
				_text_id = _text.text_id;
				
				_text_value_new = text_grid_string_get(_i,_text_id);
				
				if(_text_value_new != undefined){
					_text.value = _text_value_new;
				}
				else{
					_text.value = text_grid_string_get(_i,_text_id,TEXT_DEFAULT);
				}
			}
		
			//Update the Current Language Variable
			language_current = language_new;
		}
	}

	language_swap = false;
	
	//Save
	text_save();
}
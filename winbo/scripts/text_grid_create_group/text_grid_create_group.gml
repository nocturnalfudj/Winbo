///@param text_group
///@param directory
///@param default_list
function text_grid_create_group(_text_group,_directory,_default_group) {
	#region Build Text Group Grid
		//Get Default Group
		_default_group = script_execute(_default_group);

		//Create Grid
		var _width,_height,_grid;
		_width = 3;
		_height = ds_list_size(_default_group);
		_grid = ds_grid_create(_width,_height);
		text_grid[_text_group] = _grid;

		//ID Column
		for(var _i=0;_i<_height;_i++){
			_grid[# 0,_i] = _i;
		}

		//CURRENT and DEFAULT Columns
		for(var _i=0;_i<_height;_i++){
			_grid[# TEXT_CURRENT,_i] = _default_group[| _i];
			_grid[# TEXT_DEFAULT,_i] = _default_group[| _i];
		}

		//Destroy Default List
		ds_list_destroy(_default_group);
	#endregion

	//Import External Text Sheets
	if(!IS_BROWSER)
		text_grid_import_csv_group(_text_group,_grid,_directory);
}
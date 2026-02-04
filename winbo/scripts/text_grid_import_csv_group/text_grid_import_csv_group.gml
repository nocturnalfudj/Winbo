/// @function text_grid_import_csv_group
/// @summary Load all language grids from a directory.
///@param txtGroup
///@param txtGrid
///@param directory
function text_grid_import_csv_group(_text_group,_text_grid,_directory) {
	//Create List
	var _list,_list_size;
	_list = ds_list_create();

	#region Fill List with Available Language Grids
		//Check Directory for Language Files
		//Turn Language CSV File to Language Grid
		//Add Language Grid to List
		var _file,_grid;

		_directory += "/";
		_file = file_find_first(_directory + "*.agsts",0);
	
		if(_file!=""){
			_grid = csv_to_grd(_directory+_file);
			ds_list_add(_list,_grid);

			_file = file_find_next();
			while(_file!=""){
				_grid = csv_to_grd(_directory+_file);
				ds_list_add(_list,_grid);
				_file = file_find_next();
			}
			file_find_close();
		}

		_list_size = ds_list_size(_list);
	#endregion

	#region Save Language Grids to Group Text Grid
		var _grid,_width,_height;
		var _x1,_x2,_y1,_y2;
		var _pos_x,_pos_y;

		_width = ds_grid_width(_text_grid);
		_height = ds_grid_height(_text_grid);
		ds_grid_resize(_text_grid,_width+_list_size,_height)

		for(var _i=0;_i<_list_size;_i++){
			_grid = _list[| _i];
	
			text_grid_number_to_string(_grid);
	
			_x1 = 2;
			_x2 = 2;
			_y1 = 1;
			_y2 = ds_grid_height(_grid)-1;
	
			_pos_x = _width+_i;
			_pos_y = 0;
			ds_grid_set_grid_region(_text_grid,_grid,_x1,_y1,_x2,_y2,_pos_x,_pos_y);
			
			//Destroy Grid When Finished Copying It
			ds_grid_destroy(_grid);
		}
	#endregion
	
	//Destroy List of Language Grids
	ds_list_destroy(_list);
}
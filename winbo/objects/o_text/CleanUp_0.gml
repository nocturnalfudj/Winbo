for(var _i=0;_i<TextGroup.SIZE;_i++){
	#region Destroy Text Grids
		var _grid;
		_grid = text_grid[_i];

		if(ds_exists(_grid,ds_type_grid)){
			ds_grid_destroy(_grid);
			if(DEBUG_CLEANUP) sdm("Text grid destroyed : " + string(_grid));
		}
	#endregion
	
	#region Destroy Text Lists
		var _list;
		_list = text_list[_i];
		if(ds_exists(_list,ds_type_list)){
			ds_list_destroy(_list);
			if(DEBUG_CLEANUP) sdm("Text List Destroyed : " + string(_list));
		}
	#endregion
}
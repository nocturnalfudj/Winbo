///@param grid
function text_grid_number_to_string(_grid) {
	var _height,_width,_cell_content;
	_height = ds_grid_height(_grid);
	_width = ds_grid_width(_grid);

	for(var _i=1;_i<_width;_i++){
		for(var _j=0;_j<_height;_j++){
			_cell_content = _grid[# _i,_j];
		
			if(typeof(_cell_content) != "string"){
				_grid[# _i,_j] = string(_cell_content);
			}
		}
	}
}

/// @function subdivide_box
/// @summary Split a box area into smaller sections and return their centres.
/// @param _subdivision_count Desired number of subdivisions.
/// @param _width Width of the original box.
/// @param _height Height of the original box.
/// @param _subdivision_max_width Maximum width of each section.
function subdivide_box(_subdivision_count,_width,_height,_subdivision_max_width){
	//Calculate Rows and Columns
	var _column_count,_row_count;
	_column_count = floor(sqrt(_subdivision_count));
	_row_count = ceil(_subdivision_count / _column_count);

	//Check if cell width exceeds maxWidth and increase numberOfColumns if necessary
	while(_width / _column_count > _subdivision_max_width){
		_column_count += 1;
		_row_count = ceil(_subdivision_count / _column_count);
	}

	//Calculate Sub Box Dimensions
	var _sub_width,_sub_height,_row,_column;
	_sub_width = _width / _column_count;
	_sub_height = _height / _row_count;

	//Calculate Center Positions of Each Subdivision
	var _x,_y;
	for(_row=0;_row<_row_count;++_row){
		for(_column=0;_column<_column_count;++_column){
			//Calculate Position
			_x = x + _column * _sub_width + _sub_width/2;
			_y = y + _row * _sub_height + _sub_height/2;
		}
	}
}
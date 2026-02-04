///@param grid
///@param column
///@param column_height
function roll_weight_from_grid_column(_grid,_column,_column_height) {
	var _weight_sum;
	_weight_sum = 0;
	for(var _i=0;_i<_column_height;_i++){
		_weight_sum += _grid[# _column,_i];
	}

	if(_weight_sum > 0){
		var _rand;
		_rand = random(_weight_sum);

		var _weight_sum_cumulative,_roll;
		_roll = 0;
		_weight_sum_cumulative = 0;
		for(var _i=0;_i<_column_height;_i++){
			_weight_sum_cumulative += _grid[# _column,_i];
	
			if(_rand < _weight_sum_cumulative){
				_roll = _i;
				break;
			}	
		}

		return _roll;
	}
	else{
		return -1;
	}
}
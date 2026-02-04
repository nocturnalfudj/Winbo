/// @function roll_weight_from_array
/// @summary Select an index based on weighted array values.
/// @param _array Array of weights.
/// @returns {real} Index chosen or -1 if weights sum to zero.
function roll_weight_from_array(_array) {
	var _array_length;
	_array_length = array_length(_array);
	
	var _weight_sum;
	_weight_sum = 0;
	for(var _i=0;_i<_array_length;_i++){
		_weight_sum += _array[_i];
	}

	if(_weight_sum > 0){
		var _rand;
		_rand = random(_weight_sum);

		var _weight_sum_cumulative,_roll;
		_roll = 0;
		_weight_sum_cumulative = 0;
		for(var _i=0;_i<_array_length;_i++){
			_weight_sum_cumulative += _array[_i];
	
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
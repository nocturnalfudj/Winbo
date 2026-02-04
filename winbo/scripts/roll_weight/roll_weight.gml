///@param w_0
///@param w_1
///@param ...
///@param w_n
function roll_weight() {
	var _argument_num;
	_argument_num = argument_count;

	var _weight_sum;
	_weight_sum = 0;
	for(var _i=0;_i<_argument_num;_i++){
		_weight_sum += argument[_i];
	}

	if(_weight_sum > 0){
		var _rand;
		_rand = random(_weight_sum);

		var _weight_sum_cumulative,_roll;
		_roll = 0;
		_weight_sum_cumulative = 0;
		for(var _i=0;_i<_argument_num;_i++){
			_weight_sum_cumulative += argument[_i];
	
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
/// @function approach_target_value
/// @summary Move a value toward a target by a fixed amount each call.
/// @param _start Current value.
/// @param _target Desired target value.
/// @param _amount Step amount applied toward the target.
/// @returns {real} Updated value after the step.
function approach_target_value(_start,_target,_amount){
	//Start is Below Target
	if(_start < _target){
		//Increase Start Value
		_start += _amount;
		
		//If Start Has Gone Past Target Set it to Target
		if(_start > _target)
			_start = _target
	}
	//Else Start is Above Target
	else if(_start > _target){
		//Decrease Start Value
		_start -= _amount;
		
		//If Start Has Gone Past Target Set it to Target
		if(_start < _target)
			_start = _target
	}
	//Start is Equal to Target
	else{
		//Return Target
		return _target;
	}
	
	//Return New Start
	return _start;
}
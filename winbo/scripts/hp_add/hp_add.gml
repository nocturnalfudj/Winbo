/// @function hp_add
/// @summary Add health to the current entity and handle overhealth.
/// @param _value Amount of HP to add.
/// @param _ignore_overhealth Skip overhealth logic when true.
/// @returns {void} No return value.
function hp_add(_value,_ignore_overhealth){
	//Store Pre Value Add HP
	var _initial_hp;
	_initial_hp = hp;
	
	//Add Value
	hp += _value;
	
	//HP Over Max
	if(hp >= hp_max){
		//Default to Offer Overhealth
		_ignore_overhealth ??= false;
		if((!_ignore_overhealth) && (hp_overhealth_enable)){
			var _overhealth_value;
			_overhealth_value = _value;
			
			//Get Initial Difference Between HP and Max
			var _initial_hp_max_difference;
			_initial_hp_max_difference = hp_max - _initial_hp;
		
			if(_initial_hp_max_difference > 0){
				_overhealth_value -= _initial_hp_max_difference;
			}
		
			hp_overhealth += _overhealth_value;
		}
	}
}
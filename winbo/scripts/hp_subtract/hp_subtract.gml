/// @function hp_subtract
/// @summary Reduce health while respecting minimum and overhealth rules.
/// @param _value Amount of health to subtract.
/// @param _ignore_overhealth Whether to skip reducing overhealth.
/// @param _min_hp_value Optional minimum HP allowed after subtraction.
function hp_subtract(_value,_ignore_overhealth,_min_hp_value){
	//Store Pre Value Add HP
	var _initial_hp;
	_initial_hp = hp;
	
	// Adjust Value to Prevent Going Below Min HP
	if (_min_hp_value != undefined) {
		if (hp - _value < _min_hp_value) {
			_value = hp - _min_hp_value;
		}
	}
	
	//Subtract Value
	hp -= _value;
	
	//Default to Remove Overhealth
	_ignore_overhealth ??= false;
	if((!_ignore_overhealth) && (hp_overhealth_enable)){
		hp_overhealth -= _value;
		hp_overhealth = max(hp_overhealth,0);
	}
}
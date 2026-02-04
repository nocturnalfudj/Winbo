function console_text_field_autofill_argument_slot_update(){
	//Default to Non Valid
	command_argument_slot = -1;
	
	var _command_subject;
	_command_subject = command_subject;
	if(command_subject == CMDSubject.object || command_subject == CMDSubject.instance)
		_command_subject = CMDSubject.instance_object;
					
	//Get Position of First Space Character
	var _text_string_space_pos;
	_text_string_space_pos = string_pos(" ",text_string);
	
	//Get Position of Second Space Character
	var _text_string_space_pos_second;
	_text_string_space_pos_second = string_pos_ext(" ",text_string,_text_string_space_pos+1);
				
	var _max_argument_count,_argument_autofill_array;
	_max_argument_count = noone;
	_argument_autofill_array = noone;
	with(o_console.command_subject[_command_subject].action_list[| command_action]){
		//Get Max Number of Arguments from Action
		_max_argument_count = argument_num;
				
		//Get Action Argument Autofill Array
		_argument_autofill_array = argument_autofill;
	}
				
	//No Arguments then Exit
	if(_max_argument_count <= 0)
		exit;
				
	//If No Autofills then Exit
	if((_argument_autofill_array == noone) || (_argument_autofill_array[0][0] == noone))
		exit;
				
	#region Determine Argument Slot
		// Calculate the starting position and length for the argument substring
		var _argument_start_pos,_argument_length
		_argument_start_pos = _text_string_space_pos_second + 1;
		_argument_length = string_length(text_string) - _argument_start_pos + 1;

		// Extract the argument substring
		var _argument_string;
		_argument_string = string_copy(text_string, _argument_start_pos, _argument_length);
				
		// Determine Argument Slot
		var _argument_slot;
		_argument_slot = string_count(",",_argument_string);
	#endregion
				
	//Gone Past Max Argument Count
	if(_argument_slot > _max_argument_count)
		exit;
					
	//No Autofill for Argument Slot
	if(array_length(_argument_autofill_array) <= _argument_slot)
		exit;
		
	//Update Stored Argument Slot
	command_argument_slot = _argument_slot;
}
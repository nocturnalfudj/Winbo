/// @function console_action_argument_autofill_add
/// @summary Add an autofill entry for a console command argument.
/// @param _subject_id Subject identifier.
/// @param _action_string Name of the command.
/// @param _argument_slot Parameter index to modify.
/// @param _argument_autofill_position Position within the autofill list.
/// @param _argument_autofill_string Value to add for completion.
/// @returns {void} No return value.
function console_action_argument_autofill_add(_subject_id,_action_string,_argument_slot,_argument_autofill_position,_argument_autofill_string){
	with(o_console){
		var _action_num,_action_data;
		_action_num = command_subject[_subject_id].action_num;
		for(var _i=0;_i<_action_num;_i++){
			_action_data = command_subject[_subject_id].action_list[| _i];
			with(_action_data){
				if(action_string == _action_string){
					argument_autofill[_argument_slot][_argument_autofill_position] = _argument_autofill_string;
				}
			}
		}
	}
}
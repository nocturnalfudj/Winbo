/// @function cmd_instance_object_set_x
/// @summary Console command to set the X position of an instance.
/// @param _subject Instance to modify.
/// @param _argument_list List with the new X value.
function cmd_instance_object_set_x(_subject,_argument_list) {
	var _val;
	_val = _argument_list[| 0];

	with(_subject){
		if(string_is_real(_val)){
			_val = real(_val);
			x = _val;
			
			sdm("X in instance " + string(id) + " set to " + string(_val),LOG_COLOUR_COMMAND_SUCCESS);
		}
		else{
			sdm("Argument is invalid, must be a number : " + _val,LOG_COLOUR_COMMAND_ERROR);
		}
	}
}
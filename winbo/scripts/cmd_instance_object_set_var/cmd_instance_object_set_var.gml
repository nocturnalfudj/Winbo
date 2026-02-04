function cmd_instance_object_set_var(_subject,_argument_list) {
	var _var,_val;
	_var = _argument_list[| 0];
	_val = _argument_list[| 1];
	
	with(_subject){
		if(variable_instance_exists(id,_var)){
			var _variable_current,_variable_type;
			_variable_current = variable_instance_get(id,_var);
			_variable_type = typeof(_variable_current);
		
			if(_variable_type == "string"){
				variable_instance_set(id,_var,_val);
			}
			else if(string_is_real(_val)){
				_val = real(_val);
				variable_instance_set(id,_var,_val);
				
				sdm("Variable " + _var +  " in instance " + string(id) + " set to " + string(_val),LOG_COLOUR_COMMAND_SUCCESS);
			}
			else{
				sdm("Argument is invalid, must be a number : " + _val,LOG_COLOUR_COMMAND_ERROR);
			}
		}
		else{
			sdm("Variable not found : " + _var,LOG_COLOUR_COMMAND_ERROR);
		}
	}
}
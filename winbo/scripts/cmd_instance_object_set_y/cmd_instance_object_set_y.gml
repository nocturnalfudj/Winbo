function cmd_instance_object_set_y(_subject,_argument_list) {
	var _val;
	_val = _argument_list[| 0];


	with(_subject){
		if(string_is_real(_val)){
			_val = real(_val);
			y = _val;
			
			sdm("Y in instance " + string(id) + " set to " + string(_val),LOG_COLOUR_COMMAND_SUCCESS);
		}
		else{
			sdm("Argument is invalid, must be a number : " + _val,LOG_COLOUR_COMMAND_ERROR);
		}
	}
}
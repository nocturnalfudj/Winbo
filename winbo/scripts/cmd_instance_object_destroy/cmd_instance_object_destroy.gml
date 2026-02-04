function cmd_instance_object_destroy(_subject,_argument_list) {
	with(_subject){
		instance_destroy();
		
		sdm("Instance " + string(id) + " destroyed",LOG_COLOUR_COMMAND_SUCCESS);
	}
}
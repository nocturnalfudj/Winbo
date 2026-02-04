function console_state_active() {
	if(command_text!=""){
		ds_list_clear(command_subject_list);
		ds_list_clear(command_action_list);
		ds_list_clear(command_argument_list);
	
	
		console_extraction();
		console_execution();

		command_text="";
	}

	state = ConsoleState.idle;
}
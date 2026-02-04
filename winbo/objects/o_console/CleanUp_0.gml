#region Commands
	if(ds_exists(command_subject_list,ds_type_list)){
		ds_list_destroy(command_subject_list);
		if(DEBUG_CLEANUP) sdm("Command subject list destroyed. id : " + string(command_subject_list));
	}
	
	if(ds_exists(command_action_list,ds_type_list)){
		ds_list_destroy(command_action_list);
		if(DEBUG_CLEANUP) sdm("Command action list destroyed. id : " + string(command_action_list));
	}
	
	if(ds_exists(command_argument_list,ds_type_list)){
		ds_list_destroy(command_argument_list);
		if(DEBUG_CLEANUP) sdm("Command argument list destroyed. id : " + string(command_argument_list));
	}
#endregion

#region Log Save
	if(log_save_quit){
		console_log_save(log_save_quit_num);
	}
#endregion

//Destroy Log List
if(ds_exists(log,ds_type_list)){
	ds_list_destroy(log);
	if(DEBUG_CLEANUP) sdm("Debug log list destroyed. id : " + string(log));
}

//Destroy Log Colour List
if(ds_exists(log_colour,ds_type_list)){
	ds_list_destroy(log_colour);
	if(DEBUG_CLEANUP) sdm("Debug log colour list destroyed. id : " + string(log_colour));
}
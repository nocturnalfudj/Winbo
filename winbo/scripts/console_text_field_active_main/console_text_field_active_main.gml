function console_text_field_active_main() {
	sdm("");
	sdm(">" + text_string,LOG_COLOUR_COMMAND);

	if(text_string != ""){
		with(o_console){
			command_text = other.text_string;
			state = ConsoleState.active;
		}

		ds_list_add(command_list,text_string);
		command_list_pos = ds_list_size(command_list);command_list_pos = ds_list_size(command_list);
	}

	text_string = "";
	keyboard_string = text_string;

	text_field_edit_pos_move(max(1,string_length(text_string)),false);

	if(IS_MOBILE){
		//State to Idle
		ui_object_state_set(UIState.idle);
	}
	else{
		//State to Edit
		ui_object_state_set(UIState.edit);
	}
}
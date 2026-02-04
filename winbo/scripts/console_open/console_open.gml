/// @function console_open
/// @summary Activate and display the developer console window.
function console_open() {
	//State Change
	state = ConsoleState.idle;
	
	//Default to No Autofill Help
	command_autofill_help_enable = false;

	visible = true;
	
	if(CONSOLE_TXTFLD_ENABLE){
		with(text_field_id){
			visible = true;
			text_edit_enable = true;
		
			//State to Edit with Edit Prep
			text_field_edit_prep();
		}
	}
}
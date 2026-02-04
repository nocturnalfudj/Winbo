/// @function control_map_console_edit_stop
/// @summary Save console controls and exit edit mode.
function control_map_console_edit_stop() {
	with(o_input){
		input_save_app_control(AppControl.console);
	}
}
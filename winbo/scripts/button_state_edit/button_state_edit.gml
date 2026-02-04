/// @function button_state_edit
/// @summary Allows a button to be remapped when in edit mode.
/// @returns {void} No return value.
function button_state_edit() {
	//Custom Script Main
	ui_object_state_script_stage_execute(UIState.edit,UIStateStage.main);

	//Custom Script Stop if Not Edit Anymore
	if(state != UIState.edit)
		ui_object_state_script_stage_execute(UIState.edit,UIStateStage.stop);
}
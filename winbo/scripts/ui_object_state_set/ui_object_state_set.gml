///@param new_state
function ui_object_state_set(_state_new) {
	state = _state_new;

	ui_object_state_script_stage_execute(state,UIStateStage.start);
}
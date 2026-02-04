///@param new_state
function interact_space_state_set(_state_new) {
	state = _state_new;

	interact_space_state_script_stage_execute(state,UIStateStage.start);
}
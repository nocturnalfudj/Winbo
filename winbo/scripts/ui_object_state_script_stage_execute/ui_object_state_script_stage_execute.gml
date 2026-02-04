///@param state
///@param stage
function ui_object_state_script_stage_execute(_state,_stage) {
	var _script;
	_script = state_script[_state][_stage];

	if(_script != noone){
		script_execute(_script);
	}
}
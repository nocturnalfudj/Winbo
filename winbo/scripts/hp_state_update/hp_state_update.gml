/// @function hp_state_update
/// @summary Update the current HP state index based on thresholds.
/// @returns {void} No return value.
function hp_state_update(){
	for(var _i=0;_i<hp_state_count;_i++){
		if(hp_percent > hp_state_trigger[_i]){
			hp_state_current = _i;
			break;
		}
	}
}
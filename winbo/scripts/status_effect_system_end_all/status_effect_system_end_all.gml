/// @function status_effect_system_end_all
/// @summary Stop and remove all active status effects.
/// @returns {void} No return value.
function status_effect_system_end_all(){
	var _status_effect_data_array,_status_effect_data;
	_status_effect_data_array = o_director.status_effect;
	
	//Go Through Each Effect
	for(var _i=0;_i<StatusEffect.SIZE;_i++){
		//Effect is Active
		if(status_effect_active_count[_i] > 0){
			//End Effect
			status_effect_end(_i);
		}
	}
}
/// @function status_effect_reduce
/// @summary Decrease the active count for a status effect and end it when zero.
/// @param _status_effect_id Status effect identifier.
/// @returns {void}
function status_effect_reduce(_status_effect_id){
	//Reduce Effect
	status_effect_active_count[_status_effect_id] -= 1;
	
	//If Effect Completely Reduced
	if(status_effect_active_count[_status_effect_id] <= 0){
		//End Effect
		status_effect_end(_status_effect_id);
	}
	//More Effects to Go Through
	else{
		var _status_effect_data;
		_status_effect_data = o_director.status_effect[_status_effect_id];
	
		//Set Countdown to Duration
		status_effect_duration[_status_effect_id] = _status_effect_data.duration;
	
		//Setup Countdown Triggers
		var _time;
		if(_status_effect_data.trigger_type == StatusEffectTriggerType.countdown){
			//No Countdown Setup
			if(status_effect_trigger_countdown[_status_effect_id] == false){
				_time = _status_effect_data.trigger_countdown_max;
				status_effect_trigger_countdown[_status_effect_id].Set(_time,_time);
			}
		}
	}
}
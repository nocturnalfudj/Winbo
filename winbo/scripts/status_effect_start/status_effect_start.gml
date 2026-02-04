function status_effect_start(_status_effect_id,_duration,_time){
	var _status_effect_data;
	_status_effect_data = o_director.status_effect[_status_effect_id];
	
	//Set Countdown to Duration
	_duration ??= _status_effect_data.duration;
	status_effect_duration[_status_effect_id] = _duration;
	
	//Setup Countdown Triggers
	if(_status_effect_data.trigger_type == StatusEffectTriggerType.countdown){
		//No Countdown Setup
		if(status_effect_trigger_countdown[_status_effect_id] == false){
			_time ??= _status_effect_data.trigger_countdown_max;
			status_effect_trigger_countdown[_status_effect_id] = new Countdown(_time,_time);
		}
	}
	
	//Add 1 Effect
	status_effect_active_count[_status_effect_id] += 1;
	
	//Clamp Effect Active Count to Max
	status_effect_active_count_increased = true;
	if(status_effect_active_count[_status_effect_id] > _status_effect_data.active_max){
		status_effect_active_count[_status_effect_id] = _status_effect_data.active_max;
		status_effect_active_count_increased = false;
		
		//Don't Run Effect Start Script
		//Max active count already reached, so all this has done is reset the duration
		exit;
	}
	
	//Run Effect Start Script
	var _start_script;
	_start_script = _status_effect_data.start_script;
	if(_start_script != noone)
		script_execute(_start_script);
}
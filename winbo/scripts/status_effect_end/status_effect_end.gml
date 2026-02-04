function status_effect_end(_status_effect_id){
	var _status_effect_data;
	_status_effect_data =  o_director.status_effect[_status_effect_id];
	
	//Reset Countdown to Duration
	status_effect_duration[_status_effect_id] = _status_effect_data.duration;
					
	//Disable Effect
	status_effect_active_count[_status_effect_id] = 0;
	
	//Run Effect End Script
	var _end_script;
	_end_script = _status_effect_data.end_script;
	if(_end_script != noone)
		script_execute(_end_script);
}
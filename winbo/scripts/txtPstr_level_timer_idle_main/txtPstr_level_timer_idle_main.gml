function txtPstr_level_timer_idle_main(){
	var _level_timer;
	_level_timer = 0;
	with(o_director){
		_level_timer = level_timer;
	}
	
	text_string = seconds_to_time_format(_level_timer);
}
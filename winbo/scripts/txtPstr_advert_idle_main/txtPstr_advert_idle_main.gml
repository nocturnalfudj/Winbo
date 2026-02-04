function txtPstr_advert_idle_main() {
	var _time_left;
	_time_left = o_master.advert_force_exit_countdown.time / SECOND;
	_time_left = seconds_to_time_format(_time_left);
	
	text_string = _time_left
	
	advert_force_exit_percent = o_master.advert_force_exit_countdown.percent;
}
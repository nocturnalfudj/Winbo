function status_effect_end_buzzed_boost(){
	//Set Input Acceleration Back to Default
	var _speed_boost;
	_speed_boost = 0.5;
	movement_input_move_acceleration_factor_set(input_move_acceleration_factor - _speed_boost);
}
/// @function status_effect_start_slow
/// @summary Reduce player acceleration when this status effect begins.
function status_effect_start_slow(){
	//Decrease Input Acceleration
	var _slow;
	_slow = 0.5;
	movement_input_move_acceleration_factor_set(input_move_acceleration_factor - _slow);
}
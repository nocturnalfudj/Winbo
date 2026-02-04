/// @function status_effect_end_slow
/// @summary Remove the slow movement debuff.
function status_effect_end_slow(){
	//Restore Acceleration
	var _slow;
	_slow = 0.5;
	movement_input_move_acceleration_factor_set(input_move_acceleration_factor + _slow);
}
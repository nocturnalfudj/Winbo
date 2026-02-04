/// @function character_effect_end_speed_boost
/// @summary Reset movement acceleration when a speed boost ends.
/// @returns {void}
function character_effect_end_speed_boost(){
	//Set Input Acceleration Back to Default
	movement_input_move_acceleration_set_to_default();
}
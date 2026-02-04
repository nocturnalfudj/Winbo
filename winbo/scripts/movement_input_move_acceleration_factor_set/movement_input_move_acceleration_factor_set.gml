/// @function movement_input_move_acceleration_factor_set(value)
/// @description Sets the factor by which the move acceleration is multiplied.
/// @param {real} value The multiplication factor (1 is default).
function movement_input_move_acceleration_factor_set(_input_move_acceleration_factor){
	//Update Input Move Acceleration Factor
	input_move_acceleration_factor = _input_move_acceleration_factor;
	
	#region Calculate Terminal Velocity
		//If Velocity Retention is 1
		if(velocity_retention == 1){
			//Set Terminal Velocity Retention to Maximum Acceleration (can't divide by 0)
			velocity_input_terminal = INPUT_MOVE_ACCELERATION;
		}
		//Otherwise
		else{
			//Terminal Velocity Calculation
			velocity_input_terminal = (velocity_retention*INPUT_MOVE_ACCELERATION)/(1-velocity_retention);
		}
	#endregion
	
	//Determine Velocity Percent
	velocity_input_percent = velocity_mag/velocity_input_terminal;
}

//NOTE: Use direct assignment (input_move_acceleration_factor = value) during initialization
//Use this function only when the movement system is already fully initialized
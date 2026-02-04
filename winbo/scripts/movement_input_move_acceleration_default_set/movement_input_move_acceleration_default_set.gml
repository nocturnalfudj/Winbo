/// @function movement_input_move_acceleration_default_set
/// @summary Configure the base move acceleration used by the movement system.
/// @param _input_move_acceleration Acceleration value to set as default.
/// @returns {void}
function movement_input_move_acceleration_default_set(_input_move_acceleration){
	//Update Default
	input_move_acceleration_default = _input_move_acceleration;
		
	#macro INPUT_MOVE_ACCELERATION (input_move_acceleration_default * input_move_acceleration_factor)
	
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
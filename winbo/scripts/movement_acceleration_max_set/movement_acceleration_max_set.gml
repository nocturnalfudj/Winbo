/// @function movement_acceleration_max_set
/// @summary Change the maximum acceleration and recalculate terminal velocity.
/// @param _accelerate_max New max acceleration value.
/// @returns {void} No return value.
function movement_acceleration_max_set(_accelerate_max){
	//Update Velocity Retention & Max Acceleration
	acceleration_max = _accelerate_max;
	
	#region Calculate Terminal Velocity
		//If Velocity Retention is 1
		if(velocity_retention == 1){
			//Set Terminal Velocity Retention to Maximum Acceleration (can't divide by 0)
			velocity_terminal = acceleration_max;
		}
		//Otherwise
		else{
			//Terminal Velocity Calculation
			velocity_terminal = (velocity_retention*acceleration_max)/(1-velocity_retention);
		}
	#endregion
	
	//Determine Velocity Percent
	velocity_percent = velocity_mag/velocity_terminal;
}
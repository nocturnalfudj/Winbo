/// @function movement_velocity_retention_and_acceleration_max_set
/// @summary Configure velocity retention and max acceleration.
/// @param {real} _velocity_retention Fraction of speed kept each step.
/// @param {real} _accelerate_max Maximum acceleration allowed.
function movement_velocity_retention_and_acceleration_max_set(_velocity_retention,_accelerate_max){
	//Update Velocity Retention & Max Acceleration
	velocity_retention = _velocity_retention;
	velocity_retention_default = _velocity_retention;
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
	
	//Determin Velocity Percent
	velocity_percent = velocity_mag/velocity_terminal;
}
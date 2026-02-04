function movement_velocity_retention_set(_velocity_retention){
	//Update Velocity Retention
	velocity_retention = _velocity_retention;
	velocity_retention_default = _velocity_retention;
	
	#region Calculate Terminal Velocity
		//If Velocity Retention is 1
		if(velocity_retention == 1){
			//Set Terminal Velocity Retention to Maximum Acceleration (can't divide by 0)
			velocity_terminal = acceleration_max;
			velocity_input_terminal = INPUT_MOVE_ACCELERATION;
		}
		//Otherwise
		else{
			//Terminal Velocity Calculation
			velocity_terminal = (velocity_retention*acceleration_max)/(1-velocity_retention);
			velocity_input_terminal = (velocity_retention*INPUT_MOVE_ACCELERATION)/(1-velocity_retention);
		}
	#endregion
	
	//Determine Velocity Percent
	velocity_percent = velocity_mag/velocity_terminal;
	velocity_input_percent = velocity_mag/velocity_input_terminal;
}
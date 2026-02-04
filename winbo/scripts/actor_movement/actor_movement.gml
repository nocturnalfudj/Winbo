/// @function actor_movement
/// @summary Apply input acceleration and update movement effects.
function actor_movement() {
	#region Input Acceleration
		if(input_move_magnitude != 0){
			var _input_acceleration_mag;
			_input_acceleration_mag = input_move_magnitude * INPUT_MOVE_ACCELERATION;
			acceleration.AddMagnitudeDirection(_input_acceleration_mag,input_move_direction);
		}
	#endregion

	//Update Movement system
	movement_system_update();

	//Transform Effects
	movement_effects_update();
}
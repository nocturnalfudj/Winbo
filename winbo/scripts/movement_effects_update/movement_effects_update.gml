function movement_effects_update() {
	//Exit if Not Enabled
	if(!move_effects_enable)
		exit;
		
	//Start with No Effect
	var _x_scl,_y_scl;
	_x_scl = 1;
	_y_scl = 1;

	//Calculate Velocity Percent for Effects
	var _velocity_percent;
	_velocity_percent = min(move_effects_velocity_percent_max,velocity_input_percent);

	//Handle Speed Stretching if Enabled
	if(speed_stretch_enable){
		_x_scl += speed_stretch_scale.x * _velocity_percent;
		_y_scl += speed_stretch_scale.y * _velocity_percent;
	}

	//Handle Wave Based Wobble if Enabled
	if(wobble_enable){
		var _wave,_wobble_x,_wobble_y;
		_wave = o_master.master_wave[wobble_wave];
	
		_wobble_x = _wave*wobble_scale.x;
		_wobble_y = _wave*wobble_scale.y;
	
		_x_scl += _wobble_x * _velocity_percent;
		_y_scl += _wobble_y * _velocity_percent;
	}
	
	with(move_effects_scale){
		x = lerp(x,_x_scl,0.3);
		y = lerp(y,_y_scl,0.3);
	}
	
	//Acceleration Sway
	if(acceleration_sway_enable && (INPUT_MOVE_ACCELERATION != 0)){
		var _acceleration_percent,_acceleration_sway_target;
		_acceleration_percent = acceleration.x / INPUT_MOVE_ACCELERATION;
		if(abs(_acceleration_percent) > 1)
			_acceleration_percent = sign(_acceleration_percent);
		
		_acceleration_sway_target = acceleration_sway_max * -_acceleration_percent;
			
		acceleration_sway = lerp(acceleration_sway,_acceleration_sway_target,acceleration_sway_lerp_val);
	}
}
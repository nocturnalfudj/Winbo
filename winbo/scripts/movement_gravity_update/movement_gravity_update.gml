function movement_gravity_update(){
	//Exit if Not Enabled
	if(!move_gravity_enable)
		exit;
	
	//If Off the Ground
	if(!move_grounded){
		if(move_gravity_rise_fall_enable){
			var _move_gravity,_lerp;
			if(state == dash_state){
				_move_gravity = move_gravity_dash;
				_lerp = move_gravity_dash_lerp;
				move_gravity.LerpFactor(_move_gravity,_lerp);
			}
			else if(state == float_state){
				_move_gravity = move_gravity_float;
				_lerp = move_gravity_float_lerp;
				move_gravity.LerpFactor(_move_gravity,_lerp);
			}
			else if(velocity.y >= 0){
				_move_gravity = move_gravity_fall;
				_lerp = move_gravity_fall_lerp;
				move_gravity.LerpFactor(_move_gravity,_lerp);
			}
			else if(velocity.y < 0){
				_move_gravity = move_gravity_rise;
				_lerp = move_gravity_rise_lerp;
				move_gravity.LerpFactor(_move_gravity,_lerp);
			}
		}
		
		move_gravity.MultiplyFactor(move_gravity_factor);
		acceleration.Add(move_gravity);
	}
}
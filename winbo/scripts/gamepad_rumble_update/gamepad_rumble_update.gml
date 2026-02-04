function gamepad_rumble_update(){
	var _delta_time;
	_delta_time = global.delta_time_factor;
	
	var _update,_value_left,_value_right;
	for(var _i=0;_i<GAMEPAD_DEVICE_MAX;_i++){
		with(gamepad[_i]){
			_update = false;
			//Left
			with(rumble_left){	
				if(animating){
					transform_value_update(_delta_time,-1);
					_update = true;
				}
				
				_value_left = current;
			}
	
			//Right
			with(rumble_right){
				if(animating){
					transform_value_update(_delta_time,-1);
					_update = true;
				}
				
				_value_right = current;
			}
			
			//Update Vibration
			if(_update){
				gamepad_set_vibration(_i,_value_left,_value_right);
			}
		}
	}
}
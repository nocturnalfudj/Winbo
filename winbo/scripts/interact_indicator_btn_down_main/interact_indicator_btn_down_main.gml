function interact_indicator_btn_down_main(){
	#region Update Position
		var _position_relative_instance_exists;
		_position_relative_instance_exists = false;
	
		var _x,_y;
		_x = x;
		_y = y;
		with(position_relative_instance){
			_position_relative_instance_exists = true;
		
			_x = x;
			_y = y;
		}
	
		if(_position_relative_instance_exists){
			_x += position_relative_x;
			_y += position_relative_y;
	
			var _transform;
			_transform = transform[TransformType.anchor];
			transform_set(_transform,TransformValue.x,_x,false);
			transform_set(_transform,TransformValue.y,_y,false);
		}
	#endregion
	
	#region Add to Interaction Down Time
		var _control_pressed_required;
		_control_pressed_required = false;
	
		with(interaction){
			down_time_current += global.delta_time_factor;
			
			indicator_object_contributing_to_down_time = true;
			
			_control_pressed_required = control_pressed_required;
		}
	#endregion
	
	#region Update Down Percent
		if(down_time_indicator_enable){
			var _percent;
			_percent = 0;
			
			with(interaction){
				_percent = down_time_current / down_time_required;
			}
			
			if(_percent > 1)
				_percent = 1;
				
			down_time_indicator_percent = _percent;
		}
	#endregion
	
	//If Press is Required and Percent is 100%
	if((_control_pressed_required) && (_percent >= 1)){
		//Go to Idle
		ui_object_state_set(UIState.idle);
	}
}
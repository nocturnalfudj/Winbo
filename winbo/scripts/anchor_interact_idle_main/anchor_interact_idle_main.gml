function anchor_interact_idle_main(){
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
}
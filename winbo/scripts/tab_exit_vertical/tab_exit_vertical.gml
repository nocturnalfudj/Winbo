function tab_exit_vertical(_direction,_time_current){
	if(_direction = undefined)
		_direction = -1;
		
	var _camera_height;
	_camera_height = o_camera.height_ini;
	
	//Swipe Transform Animation
	var _transform,_target,_time_max,_ease;
	_transform = transform[TransformType.anchor];
	_target = _camera_height * _direction;
	_time_current ??= 0;
	_time_max = SECOND*0.4;
	_ease = ease_quart_out;
			
	transform_animate_from_current(_transform,TransformValue.y,_target,_time_current,_time_max,_ease,false);
				
	ui_object_state_set(UIState.destroy);
}
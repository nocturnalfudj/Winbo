function tab_exit_horizontal(_direction,_time_current){
	if(_direction = undefined)
		_direction = -1;
		
	var _camera_width;
	_camera_width = o_camera.width_ini;
	
	//Swipe Transform Animation
	var _transform,_target,_time_max,_ease;
	_transform = transform[TransformType.anchor];
	_target = _camera_width * _direction;
	_time_current ??= 0;
	_time_max = SECOND*0.4;
	_ease = ease_quad_out;
			
	transform_animate_from_current(_transform,TransformValue.x,_target,_time_current,_time_max,_ease,false);
				
	ui_object_state_set(UIState.destroy);
}
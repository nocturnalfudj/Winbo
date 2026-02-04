/// @function tab_entrance_horizontal
/// @summary Slide the tab horizontally into view.
/// @param _direction Direction multiplier (1 or -1).
/// @param _time_current Current animation time offset.
/// @returns {void} No return value.
function tab_entrance_horizontal(_direction,_time_current){
	if(_direction = undefined)
		_direction = -1;
	
	var _camera_width;
	_camera_width = o_camera.width_ini;
	
	//Swipe Transform Animation
	var _transform,_start,_time_max,_ease;
	_transform = transform[TransformType.anchor];
	_start = _camera_width * _direction;
	_time_current ??= 0;
	_time_max = SECOND*0.6;
	_ease = ease_back_out;
			
	transform_animate(_transform,TransformValue.x,_start,0,_time_current,_time_max,_ease,false);
	transform_animate(_transform,TransformValue.alpha,0,1,_time_current,_time_max*0.1,_ease,false);
	
	//State to Idle
	state = UIState.idle;
}
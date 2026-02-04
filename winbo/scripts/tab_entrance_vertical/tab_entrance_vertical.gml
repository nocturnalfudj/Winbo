/// @function tab_entrance_vertical
/// @summary Slide a tab on or off screen vertically.
/// @param _direction   Direction to slide (1 or -1)
/// @param _time_current Current animation time
function tab_entrance_vertical(_direction,_time_current){
	if(_direction == undefined)
		_direction = -1;

	var _camera_height;
	_camera_height = o_camera.height_ini;

	//Swipe Transform Animation
	var _transform,_start,_time_max,_ease;
	_transform = transform[TransformType.anchor];
	_start = _camera_height * _direction;
	_time_current ??= 0;
	_time_max = SECOND*0.4;
	_ease = ease_quart_out;

	transform_animate(_transform,TransformValue.y,_start,0,_time_current,_time_max,_ease,false);
	transform_animate(_transform,TransformValue.alpha,0,1,_time_current,_time_max*0.1,_ease,false);

	//State to Idle
	state = UIState.idle;
}
/// @function camera_state_stationary
/// @summary Keep the camera anchored at a specific target point.
function camera_state_stationary() {
	var _x,_y;
	_x = transform[TransformType.anchor].value[TransformValue.x].current;
	_y = transform[TransformType.anchor].value[TransformValue.y].current;

	//Lerp to Static Transform Target
	_x = lerp_with_gap_close(_x,stationary_target.x,CAMERA_STATIONARY_LERP_FACTOR_X,0.1);
	_y = lerp_with_gap_close(_y,stationary_target.y,CAMERA_STATIONARY_LERP_FACTOR_Y,0.1);

	//Update Object Transform
	var _transform;
	_transform = transform[TransformType.anchor];
	transform_set(_transform,TransformValue.x,_x,false);
	transform_set(_transform,TransformValue.y,_y,false);
}
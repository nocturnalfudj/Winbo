/// @function scroll_slider_down_start
/// @summary Animate the scroll slider when it is pressed.
/// @returns {void}
function scroll_slider_down_start(){
	var _transform,_transform_value,_target,_time_current,_time_max,_curve;
	_transform = transform[TransformType.anchor];
	_time_current = 0;
	_time_max = 0.2*SECOND;
	_curve = ease_quad_out;

	#region TransformValue.colour
		_transform_value = TransformValue.colour;
		_target = c_ltgray;	
		transform_animate_from_current(_transform,_transform_value,_target,_time_current,_time_max,_curve);
	#endregion
}
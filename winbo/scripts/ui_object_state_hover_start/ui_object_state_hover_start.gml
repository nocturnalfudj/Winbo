function ui_object_state_hover_start() {
	var _transform,_transform_value,_target,_time_current,_time_max,_curve;
	_transform = transform[TransformType.anchor];
	_time_current = 0;
	_time_max = 0.2*SECOND;
	_curve = ease_quad_out;

	#region TransformValue.xscale
		_transform_value = TransformValue.xscale;
		_target = 1.1 * _transform.value[_transform_value].rest;	
		transform_animate_from_current(_transform,_transform_value,_target,_time_current,_time_max,_curve);
	#endregion

	#region TransformValue.yscale
		_transform_value = TransformValue.yscale;
		_target = 1.1 * _transform.value[_transform_value].rest;		
		transform_animate_from_current(_transform,_transform_value,_target,_time_current,_time_max,_curve);
	#endregion

	#region TransformValue.colour
		_transform_value = TransformValue.colour;
		_target = c_white;	
		transform_animate_from_current(_transform,_transform_value,_target,_time_current,_time_max,_curve);
	#endregion
	
	with(window){
		window_surface_redraw_set(_time_max);
	}
}
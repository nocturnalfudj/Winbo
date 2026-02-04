/// @function ui_object_state_idle_start
/// @summary Kick off the idle animation recoil for a UI object.
function ui_object_state_idle_start() {
	var _transform,_time_max,_time_current,_time_max,_curve;
	_transform = transform[TransformType.anchor];
	_time_current = 0;
	_time_max = 0.25*SECOND;
	_curve = ease_quad_out;

	transform_recoil(_transform,TransformValue.x,_time_current,_time_max,_curve);
	transform_recoil(_transform,TransformValue.y,_time_current,_time_max,_curve);
	transform_recoil(_transform,TransformValue.yscale,_time_current,_time_max,_curve);
	transform_recoil(_transform,TransformValue.xscale,_time_current,_time_max,_curve);
	transform_recoil(_transform,TransformValue.alpha,_time_current,_time_max,_curve);
	transform_recoil(_transform,TransformValue.angle,_time_current,_time_max,_curve);
	transform_recoil(_transform,TransformValue.colour,_time_current,_time_max,_curve);
	
	with(window){
		window_surface_redraw_set(_time_max);
	}
}

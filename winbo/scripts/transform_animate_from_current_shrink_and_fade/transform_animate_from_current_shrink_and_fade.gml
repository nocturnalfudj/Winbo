/// @function transform_animate_from_current_shrink_and_fade
/// @summary Scale and fade a transform from its current values.
/// @param _time_max Duration of the animation.
/// @param _ease Easing function to use.
/// @param _time_current Offset for already elapsed time.
/// @returns {void} No return value.
function transform_animate_from_current_shrink_and_fade(_time_max,_ease,_time_current){
	var _transform,_target;
	_transform = transform[TransformType.anchor];
	_time_current ??= 0;
	_time_max ??= 0.3*SECOND;
	_ease ??= ease_quad_out;
	_target = 0;
	transform_animate_from_current(_transform,TransformValue.xscale,_target,_time_current,_time_max,_ease,false);
	transform_animate_from_current(_transform,TransformValue.yscale,_target,_time_current,_time_max,_ease,false);
	transform_animate_from_current(_transform,TransformValue.alpha,_target,_time_current,_time_max,_ease,false);
}
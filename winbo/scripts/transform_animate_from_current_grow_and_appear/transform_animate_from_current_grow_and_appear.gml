/// @function transform_animate_from_current_grow_and_appear
/// @summary Scale and fade an object in from its current values.
/// @param _time_max Duration of the animation.
/// @param _ease Easing curve to use.
/// @returns {void}
function transform_animate_from_current_grow_and_appear(_time_max,_ease){
	var _transform,_target;
	_transform = transform[TransformType.anchor];
	_time_max = (_time_max == undefined)? 0.3*SECOND : _time_max;
	_ease = (_ease == undefined)? ease_quad_out : _ease;
	_target = 1;
	transform_animate_from_current(_transform,TransformValue.xscale,_target,0,_time_max,_ease,false);
	transform_animate_from_current(_transform,TransformValue.yscale,_target,0,_time_max,_ease,false);
	transform_animate_from_current(_transform,TransformValue.alpha,_target,0,_time_max,_ease,false);
}
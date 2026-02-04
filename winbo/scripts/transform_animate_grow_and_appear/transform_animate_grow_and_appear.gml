/// @function transform_animate_grow_and_appear
/// @summary Animate a scale/alpha grow effect on the anchor transform.
/// @param [time_max=0.3*SECOND] Duration of the animation.
/// @param [ease=ease_quad_out]   Easing function applied.
/// @param [time_current=0]       Starting time offset.
function transform_animate_grow_and_appear(_time_max,_ease,_time_current){
	var _transform,_target;
	_transform = transform[TransformType.anchor];
	_time_current ??= 0;
	_time_max ??= 0.3*SECOND;
	_ease ??= ease_quad_out;
	_target = 1;
	transform_animate(_transform,TransformValue.xscale,0,_target,0,_time_max,_ease,false);
	transform_animate(_transform,TransformValue.yscale,0,_target,0,_time_max,_ease,false);
	transform_animate(_transform,TransformValue.alpha,0,_target,0,_time_max,_ease,false);
}
/// @function status_effect_start_size_boost_medium
/// @summary Grows the relative scale of the entity for a short duration.
function status_effect_start_size_boost_medium(){
	//Set Relative Scale
	var _transform,_target,_time_max,_ease;
	_transform = transform[TransformType.relative];
	_target = 1.66;
	_time_max = 0.6 * SECOND;
	_ease = ease_quad_in_out;
	transform_animate_from_current(_transform,TransformValue.xscale,_target,0,_time_max,_ease);
	transform_animate_from_current(_transform,TransformValue.yscale,_target,0,_time_max,_ease);
}
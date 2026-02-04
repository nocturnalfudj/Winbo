function status_effect_end_size_boost(){
	//Set Relative Scale
	var _transform,_target,_time_max,_ease;
	_transform = transform[TransformType.relative];
	_target = 1;
	_time_max = 0.6 * SECOND;
	_ease = ease_quad_in_out;
	//transform_animate_from_current(_transform,TransformValue.xscale,_target,0,_time_max,_ease);
	//transform_animate_from_current(_transform,TransformValue.yscale,_target,0,_time_max,_ease);

	transform_recoil(_transform,TransformValue.xscale,0,_time_max,_ease);
	transform_recoil(_transform,TransformValue.yscale,0,_time_max,_ease);
}
function ui_anchor_hide(menu_anchor){
	with(menu_anchor){
		var _transform,_time_max,_curve,_target;
		_transform = transform[TransformType.anchor];
		_time_max = 0.2*SECOND;
		_curve = ease_quad_out;
		_target = 0;
		transform_animate_from_current(_transform,TransformValue.alpha,_target,0,_time_max,_curve);
		transform_animate_from_current(_transform,TransformValue.xscale,_target,0,_time_max,_curve);
		transform_animate_from_current(_transform,TransformValue.yscale,_target,0,_time_max,_curve);
	}
}
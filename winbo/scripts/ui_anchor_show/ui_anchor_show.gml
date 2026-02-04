/// @function ui_anchor_show
/// @summary Fade in a UI anchor and set it idle.
/// @param menu_anchor Anchor instance to reveal.
/// @returns {void} No return value.
function ui_anchor_show(menu_anchor){
	with(menu_anchor){
		var _transform,_time_max,_curve,_target;
		_transform = transform[TransformType.anchor];
		_time_max = 0.2*SECOND;
		_curve = ease_quad_out;
		_target = 1;
		if((_transform.value[TransformValue.alpha].target != _target) || (_transform.value[TransformValue.alpha].animating == false))
			transform_animate_from_current(_transform,TransformValue.alpha,_target,0,_time_max,_curve);
		
		if((_transform.value[TransformValue.xscale].target != _target) || (_transform.value[TransformValue.xscale].animating == false))
			transform_animate_from_current(_transform,TransformValue.xscale,_target,0,_time_max,_curve);
			
		if((_transform.value[TransformValue.yscale].target != _target) || (_transform.value[TransformValue.yscale].animating == false))
			transform_animate_from_current(_transform,TransformValue.yscale,_target,0,_time_max,_curve);
		
		//Idle State
		state = UIState.idle;
	}
}
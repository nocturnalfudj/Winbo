/// @function transform_animate_pulse
/// @summary Quickly scales and colours the anchor transform.
/// @param {bool} _in   True for scale in, false for scale out.
/// @param {real} [_scale=3] Target scale amount.
/// @param {real} [_colour] Optional colour to animate to.
function transform_animate_pulse(_in,_scale,_colour){
	var _transform,_time_current,_time_max,_curve,_target;
	_transform = transform[TransformType.anchor];
	_time_current = 0;
	_time_max = 0.15*SECOND;
	_curve = (_in == true)? ease_expo_in : ease_expo_out;
	_target = (_scale == undefined)? 3 : _scale;
	transform_animate_from_current(_transform,TransformValue.xscale,_target,_time_current,_time_max,_curve,true);
	transform_animate_from_current(_transform,TransformValue.yscale,_target,_time_current,_time_max,_curve,true);
	
	if(_colour != undefined)
		transform_animate_from_current(_transform,TransformValue.colour,_colour,_time_current,_time_max,ease_linear,true);
}
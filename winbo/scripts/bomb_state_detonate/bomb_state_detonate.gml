/// @function bomb_state_detonate
/// @summary Begin the detonation sequence for a bomb.
function bomb_state_detonate() {
	var _transform,_start,_time_current,_time_max,_curve;
	_transform = transform[TransformType.relative];
	_start = 0;
	_time_current = 0;
	_time_max = explode_time_max;
	_curve = explode_curve_scale;
	transform_animate(_transform,TransformValue.xscale,_start,explode_scale_target,_time_current,_time_max,explode_curve_scale);
	transform_animate(_transform,TransformValue.yscale,_start,explode_scale_target,_time_current,_time_max,explode_curve_scale);
	transform_animate(_transform,TransformValue.alpha,_start,explode_alpha_target,_time_current,_time_max,explode_curve_alpha);
	if(spin_max == 0)
		transform_animate_from_current(_transform,TransformValue.angle,explode_angle_target,_time_current,_time_max,explode_curve_angle);
	
	//Flash
	flash_alpha = 1;
	
	//Update Sprite
	sprite_index = explode_sprite;
	sprite_current = sprite_index;
	
	//Go to Explode State
	state = BombState.explode;
	explode_countdown = explode_time_max;
}
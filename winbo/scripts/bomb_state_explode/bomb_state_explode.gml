/// @desc Performs the explosion effect and transitions the bomb to death state
function bomb_state_explode() {
	var _transform;
	_transform = transform[TransformType.relative];
	
	//Countdown
	if(explode_countdown > 0){
		explode_countdown -= global.delta_time_factor_scaled;
	}
	else{
		//State to Fade
		state = BombState.fade;
		fade_countdown = fade_time_max;
		
		//Trigger Fade Away Animation
		var _time_current,_time_max,_curve;
		_time_current = 0;
		_time_max = fade_time_max;
		_curve = fade_curve_scale;
		transform_animate(_transform,TransformValue.xscale,explode_scale_target,fade_scale_target,_time_current,_time_max,fade_curve_scale);
		transform_animate(_transform,TransformValue.yscale,explode_scale_target,fade_scale_target,_time_current,_time_max,fade_curve_scale);
		transform_animate(_transform,TransformValue.alpha,explode_alpha_target,fade_alpha_target,_time_current,_time_max,fade_curve_alpha);
		if(spin_max == 0)
			transform_animate(_transform,TransformValue.angle,explode_angle_target,fade_angle_target,_time_current,_time_max,fade_curve_angle);
			
		//pfx[pfx_bomb.kill_cloud][part.brst_active] = 1;
		//pfx[pfx_bomb.kill_exp][part.brst_active] = 1;
		//pfx_execute();
	}
			
	if(explode_script != noone){
		script_execute(explode_script);
	}
	
	//Spin
	spin_current = lerp_with_gap_close(spin_current,spin_max,spin_lerp_value,0.01,true);
	transform_set(transform[TransformType.anchor],TransformValue.angle,spin_current,true);
}
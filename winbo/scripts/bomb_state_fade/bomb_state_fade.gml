/// @desc Handles fade-out animation after a bomb has exploded
function bomb_state_fade() {
	//Countdown
	if(fade_countdown > 0){
		fade_countdown -= global.delta_time_factor_scaled;
	}
	else{
		//State to Death
		state = BombState.death;
	}
			
	if(fade_script != noone){
		script_execute(fade_script);
	}
	
	//Spin
	spin_current = lerp_with_gap_close(spin_current,spin_max,spin_lerp_value,0.01,true);
	transform_set(transform[TransformType.anchor],TransformValue.angle,spin_current,true);
}
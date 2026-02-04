/// @desc Final state called when a bomb has detonated and should be removed
function bomb_state_death() {
	if(camera_visible){
		//Shrink & Fade
		transform_animate_from_current_shrink_and_fade();
		
		state = BombState.destroy;
	}
	else{
		state = BombState.destroy;
	}
	
	//Spin
	spin_current = lerp_with_gap_close(spin_current,spin_max,spin_lerp_value,0.01,true);
	transform_set(transform[TransformType.anchor],TransformValue.angle,spin_current,true);
}
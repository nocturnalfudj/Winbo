/// @function bomb_state_destroy
/// @summary Handle bomb destruction animation and cleanup.
function bomb_state_destroy() {
	//Destroy instance when Transform is at rest
	transform_updated_check();
			
	//Spin
	spin_current = lerp_with_gap_close(spin_current,spin_max,spin_lerp_value,0.01,true);
	transform_set(transform[TransformType.anchor],TransformValue.angle,spin_current,true);
	
	//Finished Animating
	if(!transform_updated){
		//Repetition Complete
		if(repeat_current >= repeat_count){
			instance_destroy();
		}
		//Repeat
		else{
			//Increase Repeat Counter
			repeat_current++;
					
			//Go Back to Create
			state = BombState.create;
		}
	}
}
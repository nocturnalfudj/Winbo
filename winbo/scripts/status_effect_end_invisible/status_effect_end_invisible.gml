/// @function status_effect_end_invisible
/// @summary Restore visibility after the invisible effect ends.
/// @returns {void}
function status_effect_end_invisible(){
	//Enable Can Be Targeted
	target_can_be_targeted[TargetType.attack] = true;
	target_can_be_targeted[TargetType.move] = true;
	
	//Full Alpha
	transform_animate_from_current(transform[TransformType.anchor],TransformValue.alpha,1,0,SECOND*0.2,ease_quad_out,false);
}
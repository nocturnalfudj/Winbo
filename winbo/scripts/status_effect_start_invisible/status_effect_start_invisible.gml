function status_effect_start_invisible(){
	//Disable Can Be Targeted
	target_can_be_targeted[TargetType.attack] = false;
	target_can_be_targeted[TargetType.move] = false;
	
	//Fade Alpha
	transform_animate_from_current(transform[TransformType.anchor],TransformValue.alpha,0.5,0,SECOND*0.2,ease_quad_out,false);
}
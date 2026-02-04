function txtPstr_damage_idle_main(){
	//Flash
	if(critical || critical_super){
		if(flash_alpha > 0.01){
			flash_alpha = lerp(flash_alpha,0,0.1);
		}
		else{
			flash_alpha = 1;
		}
	}
	
	if(!transform[TransformType.anchor].value[TransformValue.alpha].animating){
		if(critical || critical_super){
			transform_animate_from_current_shrink_and_fade(0.8*SECOND,ease_back_in,-0.2*SECOND);
		}
		else{
			transform_animate_from_current_shrink_and_fade(0.2*SECOND,ease_back_in,-0.1*SECOND);	
		}
			
		//Set UI State
		ui_object_state_set(UIState.destroy);
	}
}
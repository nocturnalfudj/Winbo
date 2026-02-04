function txtPstr_heal_idle_main(){
	if(!transform[TransformType.anchor].value[TransformValue.alpha].animating){
		transform_animate_from_current_shrink_and_fade(0.2*SECOND,ease_back_in,-0.1*SECOND);
			
		//Set UI State
		ui_object_state_set(UIState.destroy);
	}
}
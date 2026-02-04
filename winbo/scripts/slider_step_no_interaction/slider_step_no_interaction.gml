/// @function slider_step_no_interaction
/// @summary Update slider state when it cannot be interacted with.
function slider_step_no_interaction() {
	//State Switch
	switch(state){
		case UIState.deactivate:
			instance_deactivate_object(id);
		break;
	
		case UIState.activate:
			ui_object_state_set(UIState.idle);
		
			//Custom Script
			ui_object_state_script_stage_execute(UIState.activate,UIStateStage.main);
		break;
	
		case UIState.create:
			slider_state_create();
		break;
	
		case UIState.idle:
			//Custom Script
			ui_object_state_script_stage_execute(state,UIStateStage.main);
		break;
	
		case UIState.destroy:
			//Custom Script
			ui_object_state_script_stage_execute(state,UIStateStage.main);
		break;
	}
	
	//Update Title & Subtitle Strings
	title_system_update();

	//Value Update
	slider_val_update();

	//Transform Update
	slider_transform_update();


}

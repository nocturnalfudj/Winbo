/// @desc Lightweight step event for buttons without interactive features
function button_step_no_interaction() {
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
			ui_object_state_create();
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

	//Transform Update
	transform_system_update();
}
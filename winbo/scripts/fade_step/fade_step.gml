/// @function fade_step
/// @summary Manage UI fade states and update transforms.
function fade_step() {
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
			//Fade Create State Script
			fade_state_create();
			
			//Custom Script
			ui_object_state_script_stage_execute(UIState.create,UIStateStage.main);
			ui_object_state_script_stage_execute(UIState.create,UIStateStage.stop);
		break;
	
		case UIState.idle:
			//Custom Script
			ui_object_state_script_stage_execute(state,UIStateStage.main);
		break;
	
		case UIState.active:
			//Custom Script
			ui_object_state_script_stage_execute(state,UIStateStage.main);
		break;
	
		case UIState.destroy:
			//Custom Script
			ui_object_state_script_stage_execute(state,UIStateStage.main);
		break;
	}

	//Transform Update
	transform_system_update();
}
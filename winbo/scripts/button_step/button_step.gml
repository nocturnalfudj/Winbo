/// @desc Central update loop for button objects managing state transitions
function button_step() {
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
			button_state_idle();
		break;
	
		case UIState.hover:
			button_state_hover();
		break;
	
		case UIState.down:
			button_state_down();
		break;
	
		case UIState.active:
			button_state_active();
		break;
	
		case UIState.edit:
			button_state_edit();
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
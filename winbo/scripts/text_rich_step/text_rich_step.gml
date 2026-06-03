/// @function text_rich_step
/// @summary Main state machine for text_rich with per-character animation
function text_rich_step() {
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
			text_rich_state_create();
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
	
	//Update Text Strings
	text_ui_text_strings_update();
	
	//Transform system update (parent)
	transform_system_update();
	
	//Rich text system update
	rich_text_system_step();
	
	//Updated Transform So Dimensions Need to be Recalculated
	if(transform_updated){
		calculate_dimensions = true;
	}

	//Recalculate Dimensions
	if(calculate_dimensions){
		text_poster_dimensions();
		
		//Camera Visible Dimensions
		camera_visible_dimensions();
	}

	//Set Previous Text Strings
	text_ui_text_strings_prev_update();
}
/// @function text_rich_button_step
/// @summary Per-frame logic for text buttons with rich text rendering
/// @returns {void}
function text_rich_button_step() {
	//State Switch (text_button states)
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
			text_rich_button_state_create();  // NEW: rich button specific
		break;
	
		case UIState.idle:
			text_button_state_idle();  // TEXT BUTTON state
		break;
	
		case UIState.hover:
			text_button_state_hover();  // TEXT BUTTON state
		break;
	
		case UIState.down:
			text_button_state_down();  // TEXT BUTTON state
		break;
	
		case UIState.active:
			text_button_state_active();  // TEXT BUTTON state
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
		text_button_dimensions();  // TEXT BUTTON dimensions (not text_poster)
		
		//Camera Visible Dimensions
		camera_visible_dimensions();
	}

	//Set Previous Text Strings
	text_ui_text_strings_prev_update();
	
}

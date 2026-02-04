/// @function window_step_no_interaction
/// @summary Update a non-interactive window each step.
/// @returns {void} Nothing.
function window_step_no_interaction() {
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

	//Transform Update
	transform_system_update();
	
	var _surface_redraw;
	_surface_redraw = transform_updated;
	
	with(scroll){
		//Move
		_surface_redraw = movement_drag_pan_update(false,1);
			
		//Transform Update
		transform_system_update();
			
		if(transform_updated)
			_surface_redraw = true;
	}
		
	if(_surface_redraw)
		window_surface_redraw_set(2);
}
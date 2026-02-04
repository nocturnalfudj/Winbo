/// @function window_step
/// @summary Update a scrollable window and manage its UI states.
/// @returns {void} Nothing.
function window_step() {
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
			window_state_idle();
		break;
	
		case UIState.hover:
			window_state_hover();
		break;
	
		case UIState.down:
			window_state_down();
		break;
	
		case UIState.active:
			window_state_active();
		break;
	
		case UIState.destroy:
			//Custom Script
			ui_object_state_script_stage_execute(state,UIStateStage.main);
		break;
	}

	//Transform Update
	transform_system_update();
	
	var _surface_redraw,_mouse_collision;
	_surface_redraw = transform_updated;
	_mouse_collision = mouse_collision;
	
	with(scroll){
		//Move
		_surface_redraw = movement_drag_pan_update(_mouse_collision,1);
			
		//Transform Update
		transform_system_update();
			
		if(transform_updated)
			_surface_redraw = true;
			
		//Disable/Enable Camera Zoom Control
		if(_mouse_collision){
			with(o_camera){
				zoom_control_enable_window_scroll = false;
			}
		}
	}
		
	if(_surface_redraw)
		window_surface_redraw_set(2);
}
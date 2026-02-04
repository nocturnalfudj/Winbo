/// @function text_field_step
/// @summary Update state logic and behaviour for a text field UI element.
/// @returns {void} No return value.
function text_field_step() {
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
			text_field_state_idle();
		break;
	
		case UIState.hover:
			text_field_state_hover();
		break;
	
		case UIState.down:
			text_field_state_down();
		break;
	
		case UIState.edit:
			text_field_state_edit();
		break;
	
		case UIState.active:
			//State to Idle
			ui_object_state_set(UIState.idle);

			//Custom Script
			ui_object_state_script_stage_execute(UIState.active,UIStateStage.main);
		break;
	
		case UIState.destroy:
			//Custom Script
			ui_object_state_script_stage_execute(state,UIStateStage.main);
		break;
	}
	
	#region Update Text Strings
		var _string;
		
		//Hint
		if(hint_text_enable){
			_string = hint_string;
			with(hint_text){
				_string = value;
			}
			hint_string = _string;
		}
		
		//Title
		if(title_enable){
			_string = title_string;
			with(title_text){
				_string = value;
			}
			title_string = _string;
		}
	#endregion

	//Transform Update
	transform_system_update();

	//Previous Text String
	text_string_prev = text_string;
}
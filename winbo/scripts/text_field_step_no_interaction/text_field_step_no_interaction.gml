function text_field_step_no_interaction() {
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

	//Previous Text String
	text_string_prev = text_string;
}
/// @function console_close
/// @summary Hide the console UI and stop text entry.
function console_close() {
	//Make Invisible
	visible = false;

	if(CONSOLE_TXTFLD_ENABLE){
		with(text_field_id){
			visible = false;
			text_edit_enable = false;
		
			//State to Idle
			ui_object_state_set(UIState.idle);
		}
	
		//Hide Mobile Keyboard
		if(IS_MOBILE && !IS_BROWSER){
			keyboard_virtual_hide();
		}
	}

	if(IS_MOBILE){
		var _transform,_transform_value,_target,_time_current,_time_max,_curve;
		_transform = transform[TransformType.anchor];
		_transform_value = TransformValue.y;
		_time_current = 0;
		_target = 0;
		_time_max = 0.5*SECOND;
		_curve = ease_elastic_in_out;
		transform_animate_from_current_relative_to_rest(_transform,_transform_value,_target,_time_current,_time_max,_curve);
	}
}
/// @function slider_state_idle
/// @summary Wait for user interaction on a UI slider.
function slider_state_idle() {
	var _state_stop,_state_current;
	_state_stop = false;
	_state_current = state;

	if(mouse_collision){
		var _mouse_button
		_mouse_button = mouse_check_button(mb_left);
	
		if(_mouse_button){
			var _other_down,_group_down;
			_other_down = false;
			_group_down = 0;
			with(o_slider){
				if(state = UIState.down){
					_other_down = true;
					_group_down = group;
				}
			}
		
			if((_other_down && (group_enable) && (group == _group_down)) || (!_other_down)){
				//State to Down
				ui_object_state_set(UIState.down);
			
				//Finished with State
				_state_stop = true;
			}
		}
		else if(!IS_MOBILE){
			//State to Hover
			ui_object_state_set(UIState.hover);
		
			//Finished with State
			_state_stop = true;
		}
		else{
			//State to Idle
			ui_object_state_set(UIState.idle);
		
			//Finished with State
			_state_stop = true;
		}
	}

	//Custom Script
	var _stage;
	_stage = (_state_stop)? UIStateStage.stop : UIStateStage.main;
	ui_object_state_script_stage_execute(_state_current,_stage);
}
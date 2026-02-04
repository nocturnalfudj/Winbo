function slider_state_down() {
	var _state_stop,_state_current;
	_state_stop = false;
	_state_current = state;

	var _mx,_my,_mouse_button,_mouse_button_released;
	
	var _mouse_device;
	_mouse_device = mouse_device;
	with(o_ui){
		_mx = mouse_gui_scale_inverted[_mouse_device].x;
		_my = mouse_gui_scale_inverted[_mouse_device].y;
	}

	_mouse_button = device_mouse_check_button(mouse_device,mb_left);

	if(_mouse_button){
		var _percent
		if(vertical){
			var _y;
			_y = clamp(_my,y-height_half,y+height_half);
			_percent = ((y+height_half) - _y)/(height);
		}
		else{
			var _x;
			_x = clamp(_mx,x-width_half,x+width_half);
			_percent = (_x - (x-width_half))/(width);
		}
	
		if(discrete)
			_percent = round(_percent*100 / (100/(discrete_count - 1))) * (1/(discrete_count - 1));
	
		value_current = _percent*(value_max - value_min)+value_min;
	
		if(live){
			//Custom Script
			ui_object_state_script_stage_execute(UIState.active,UIStateStage.main);
		}
	}
	else{
		_mouse_button_released = device_mouse_check_button_released(mouse_device,mb_left);

		if(!live && _mouse_button_released){
			//State to Active
			ui_object_state_set(UIState.active);
			
			//Finished with State
			_state_stop = true;
		}
		else if(mouse_collision){
			if(!_mouse_button_released && !_mouse_button){
				if(!IS_MOBILE){
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
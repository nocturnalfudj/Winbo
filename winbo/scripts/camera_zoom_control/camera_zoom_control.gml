/// @function camera_zoom_control
/// @summary Process user input to zoom the camera view.
/// @returns {void} No return value.
function camera_zoom_control(){
	if(CAMERA_ZOOM_ENABLE && zoom_control_enable && zoom_control_enable_window_scroll){
		var _input_zoom_in,_input_zoom_out,_input_zoom_direction;
		_input_zoom_in = false;
		_input_zoom_out = false;
		_input_zoom_direction = 0;
	
		#region Keyboard Check
			_input_zoom_in = keyboard_check(vk_add);
			_input_zoom_out = keyboard_check(vk_subtract);
	
			_input_zoom_direction = _input_zoom_out - _input_zoom_in;
		#endregion
	
		#region If No Resultant Input Check Mouse Edge Scroll
			if(_input_zoom_direction == 0){
				//Only if Console is NOT open
				if(o_console.visible == false){
					_input_zoom_in = mouse_wheel_up();
					_input_zoom_out = mouse_wheel_down();
	
					_input_zoom_direction = _input_zoom_out - _input_zoom_in;
				}
			}
		#endregion
	
		#region If No Resultant Input Check Gamepad Dpad
			if(_input_zoom_direction == 0){
				var _gamepad_device;
				_gamepad_device = global.gamepad_device_ui_control;
			
				_input_zoom_in = gamepad_button_check(_gamepad_device,gp_shoulderl);
				_input_zoom_out = gamepad_button_check(_gamepad_device,gp_shoulderr);
		
				_input_zoom_direction = _input_zoom_out - _input_zoom_in;
			}
		#endregion
	
		if(_input_zoom_direction != 0){
			var _start,_target;
			_start = zoom_anchor.current;
			_target = _start * (1 + 0.3*_input_zoom_direction);
			
			if(zoom_control_clamp_enable)
				_target = clamp(_target,zoom_control_clamp_min,zoom_control_clamp_max);
			
			transform_value_animate_from_current(zoom_anchor,_target,1,0.1*SECOND,ease_quad_out,false);
		}
	}
}
function pan_system_update(_input_allow,_zoom_scale){
	var _move_update;
	_move_update = false;
	
	if(pan_enable_x || pan_enable_y){
		#region Input
			if(_input_allow){
				var _input_x,_input_y;
				_input_x = 0;
				_input_y = 0;
				
				var _input_left,_input_right,_input_up,_input_down;
				_input_left = false;
				_input_right = false;
				_input_up = false;
				_input_down = false;
	
				#region Keyboard Check
					//Only if Console is NOT open
					if(o_console.visible == false){
						var _mouse_wheel_input;
						_mouse_wheel_input = 0;
						
						if(pan_enable_x){
							if(mouse_wheel_down())
								_mouse_wheel_input = -1 * mouse_wheel_direction_x;
							
							if(mouse_wheel_up())
								_mouse_wheel_input = 1 * mouse_wheel_direction_x;
							
							_input_left = ((pan_mouse_scroll_enable_x) && (_mouse_wheel_input == -1)) || (keyboard_check(vk_left) || keyboard_check(ord("A")));
							_input_right = ((pan_mouse_scroll_enable_x) && (_mouse_wheel_input == 1)) || (keyboard_check(vk_right) || keyboard_check(ord("D")));
							
							_input_x = _input_right - _input_left;
						
							if(pan_invert_x)
								_input_x *= -1;
						}
						
						if(pan_enable_y){
							if(mouse_wheel_down())
								_mouse_wheel_input = -1 * mouse_wheel_direction_y;
							
							if(mouse_wheel_up())
								_mouse_wheel_input = 1 * mouse_wheel_direction_y;
								
							_input_up = ((pan_mouse_scroll_enable_y) && (_mouse_wheel_input == -1)) || (keyboard_check(vk_up) || keyboard_check(ord("W")));
							_input_down = ((pan_mouse_scroll_enable_y) && (_mouse_wheel_input == 1)) || (keyboard_check(vk_down) || keyboard_check(ord("S")));
							
							_input_y = _input_down - _input_up;
						
							if(pan_invert_y)
								_input_y *= -1;
						}
					}	
				#endregion
	
				#region If No Resultant Input Check Mouse Edge Scroll
					if((_input_x == 0) && (_input_y == 0)){
						var _mouse_gui_x,_mouse_gui_y;
						with(o_ui){
							_mouse_gui_x = mouse_gui_scale_inverted[0].x;
							_mouse_gui_y = mouse_gui_scale_inverted[0].y;
						}
						
						if(pan_enable_x && pan_edge_scroll_enable_x){
							if(_mouse_gui_x <= pan_edge_scroll_min.x + PAN_EDGE_SCROLL_BUFF){
								_input_x = -1;
							}
							else if(_mouse_gui_x >= pan_edge_scroll_max.x - PAN_EDGE_SCROLL_BUFF){
								_input_x = 1;
							}
						}
						
						if(pan_enable_y && pan_edge_scroll_enable_y){
							if(_mouse_gui_y <= pan_edge_scroll_min.y + PAN_EDGE_SCROLL_BUFF){
								_input_y = -1;
							}
							else if(_mouse_gui_y >= pan_edge_scroll_max.y - PAN_EDGE_SCROLL_BUFF){
								_input_y = 1;
							}
						}
					}
				#endregion
				
				#region Gamepad
					if(GAMEPAD_ENABLE){
						#region If No Resultant Input Check Gamepad Dpad
							if((_input_x == 0) && (_input_y == 0)){
								var _gamepad_device;
								_gamepad_device = global.gamepad_device_ui_control;
						
								if(pan_enable_x){
									_input_left = gamepad_button_check(_gamepad_device,gp_padl);
									_input_right = gamepad_button_check(_gamepad_device,gp_padr);
							
									_input_x = _input_right - _input_left;
								}
						
								if(pan_enable_y){
									_input_up = gamepad_button_check(_gamepad_device,gp_padu);
									_input_down = gamepad_button_check(_gamepad_device,gp_padd);
							
									_input_y = _input_down - _input_up;
								}
							}
						#endregion
	
						#region If No Resultant Input Check Gamepad Right Stick
							if((_input_x == 0) && (_input_y == 0)){
								if(pan_enable_x)
									_input_x = gamepad_axis_value(_gamepad_device,gp_axisrh);
								
								if(pan_enable_y)
									_input_y = gamepad_axis_value(_gamepad_device,gp_axisrv);
							}
						#endregion
					}
				#endregion
	
				input_move_direction = point_direction(0,0,_input_x,_input_y);
				//input_move_magnitude = point_distance(0,0,_input_x,_input_y) * _zoom_scale;
				input_move_magnitude = ((_input_x != 0) || (_input_y != 0)) * _zoom_scale;
				
				//Input Acceleration
				acceleration.AddMagnitudeDirection(INPUT_MOVE_ACCELERATION*input_move_magnitude,input_move_direction);
			}
			
			if(input_move_magnitude > 0){
				pan_active = true;
				drag_let_go_early = false;
			}
			else{
				pan_active = false;
			}
		#endregion
			
		#region Update Movement System
			//Detla Time Factor
			var _delta_time;
			_delta_time = global.delta_time_factor;
			
			var _transform,_x,_y;
			_transform = transform[TransformType.anchor];
			with(_transform){
				_x = value[TransformValue.x].current;
				_y = value[TransformValue.y].current;
			}
				
			//Displacement
			var _displacement_x,_displacement_y,_displacement_ini;
			var _acceleration_multiplier;
			_acceleration_multiplier = 0.5*_delta_time;
			
			if(pan_enable_x){
				_displacement_x = (velocity.x + acceleration.x*_acceleration_multiplier)*_delta_time;
				
				if(_displacement_x != 0){
					var _target_x;
					_target_x = _x + _displacement_x;
					if(position_clamp_enable_x)
						_target_x = clamp(_target_x,position_clamp_min.x,position_clamp_max.x);
						
					_x = lerp_with_gap_close(_x,_target_x,PAN_LERP_FACTOR,0.1);
					transform_set(_transform,TransformValue.x,_x,false);
					
					_move_update = true;
				}
			}
			
			if(pan_enable_y){
				_displacement_y = (velocity.y + acceleration.y*_acceleration_multiplier)*_delta_time;
				
				if(_displacement_y != 0){
					var _target_y;
					_target_y = _y + _displacement_y;
					if(position_clamp_enable_y)
						_target_y = clamp(_target_y,position_clamp_min.y,position_clamp_max.y);
						
					_y = lerp_with_gap_close(_y,_target_y,PAN_LERP_FACTOR,0.1);
					transform_set(_transform,TransformValue.y,_y,false);
					
					_move_update = true;
				}
			}
				
			//Update Velocity
			movement_velocity_update(_delta_time,false);
	
			//Reset Acceleration
			acceleration.Set(0,0);
		#endregion
	}
	
	return _move_update;
}
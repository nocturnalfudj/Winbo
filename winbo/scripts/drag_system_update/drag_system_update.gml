/// @function drag_system_update
/// @summary Handle mouse dragging of a transform anchor.
/// @param _input_allow Allow user input this frame.
/// @param _zoom_scale Scale applied when converting to world space.
function drag_system_update(_input_allow,_zoom_scale){
	var _move_update;
	_move_update = false;
	
	if(drag_enable_x || drag_enable_y){
		var _transform,_x,_y;
		_transform = transform[TransformType.anchor];
			
		if(_input_allow){
			if(device_mouse_check_button_pressed(0,drag_input)){
				drag_active = true;
					
				with(_transform){
					_x = value[TransformValue.x].current;
					_y = value[TransformValue.y].current;
				}
				
				drag_start.Set(_x,_y);
				
				drag_start_mouse.Copy(o_ui.mouse_gui[0]);
			}
		
			if((drag_active) && (device_mouse_check_button(0,drag_input))){
				var _mouse_gui_x,_mouse_gui_y;
				with(o_ui){
					_mouse_gui_x = mouse_gui[0].x;
					_mouse_gui_y = mouse_gui[0].y;
				}
				
				with(_transform){
					_x = value[TransformValue.x].current;
					_y = value[TransformValue.y].current;
				}
					
				if(drag_enable_x){
					var _drag_target_x;
					_drag_target_x = (drag_start_mouse.x - _mouse_gui_x)*_zoom_scale;
					
					if(drag_invert_x)
						_drag_target_x *= -1;
						
					_drag_target_x += drag_start.x;
						
					#region Dragging Beyond Clamps
						if(position_clamp_enable_x){
							if(_drag_target_x < position_clamp_min.x){
								var _clamp_difference;
								_clamp_difference = _drag_target_x - position_clamp_min.x;
								drag_start_mouse.x += _clamp_difference;
						
								_drag_target_x = position_clamp_min.x;
							}
							else if(_drag_target_x > position_clamp_max.x){
								var _clamp_difference;
								_clamp_difference = _drag_target_x - position_clamp_max.x;
								drag_start_mouse.x += _clamp_difference;
						
								_drag_target_x = position_clamp_max.x;
							}
						}
					#endregion
						
					drag_target.x = _drag_target_x;
						
					_x = lerp_with_gap_close(_x,drag_target.x,DRAG_LERP_FACTOR,0.1);
					transform_set(_transform,TransformValue.x,_x,false);
					_move_update = true;
				}
				
				if(drag_enable_y){
					var _drag_target_y;
					_drag_target_y = (drag_start_mouse.y- _mouse_gui_y)*_zoom_scale;
					
					if(drag_invert_y)
						_drag_target_y *= -1;
						
					_drag_target_y += drag_start.y;
					
					#region Dragging Beyond Clamps
						if(position_clamp_enable_y){
							if(_drag_target_y < position_clamp_min.y){
								var _clamp_difference;
								_clamp_difference = _drag_target_y - position_clamp_min.y;
								drag_start_mouse.y += _clamp_difference;
						
								_drag_target_y = position_clamp_min.y;
							}
							else if(_drag_target_y > position_clamp_max.y){
								var _clamp_difference;
								_clamp_difference = _drag_target_y - position_clamp_max.y;
								drag_start_mouse.y += _clamp_difference;
						
								_drag_target_y = position_clamp_max.y;
							}
						}
					#endregion
					
					drag_target.y = _drag_target_y;
					
					_y = lerp_with_gap_close(_y,drag_target.y,DRAG_LERP_FACTOR,0.1);
					transform_set(_transform,TransformValue.y,_y,false);
					_move_update = true;
				}
			}
		}
			
		if(drag_active){
			if((!_input_allow) || (device_mouse_check_button_released(0,drag_input))){
				drag_active = false;
			
				with(_transform){
					_x = value[TransformValue.x].current;
					_y = value[TransformValue.y].current;
				}
				
				drag_let_go_early = !drag_target.EqualsValues(_x,_y);
				
				if(drag_let_go_early){
					if(drag_enable_x){
						var _drag_target_x_dir,_drag_target_x_dist_mag;
						_drag_target_x_dir = sign(drag_target.x - _x);
						_drag_target_x_dist_mag = abs(drag_target.x - _x);
						
						var _drag_target_x;
						_drag_target_x = drag_target.x + DRAG_LET_GO_EARLY_TARGET_DIST_FACTOR*_drag_target_x_dir*_drag_target_x_dist_mag;
						if(position_clamp_enable_x)
							_drag_target_x = clamp(_drag_target_x,position_clamp_min.x,position_clamp_max.x);
						drag_target.x = _drag_target_x;
					}
				
					if(drag_enable_y){
						var _drag_target_y_dir,_drag_target_y_dist_mag;
						_drag_target_y_dir = sign(drag_target.y - _y);
						_drag_target_y_dist_mag = abs(drag_target.y - _y);
						
						var _drag_target_y;
						_drag_target_y = drag_target.y + DRAG_LET_GO_EARLY_TARGET_DIST_FACTOR*_drag_target_y_dir*_drag_target_y_dist_mag;
						if(position_clamp_enable_y)
							_drag_target_y = clamp(_drag_target_y,position_clamp_min.y,position_clamp_max.y);
						drag_target.y = _drag_target_y;
					}
				}
			}
		}
		
		if(drag_let_go_early){
			with(_transform){
				_x = value[TransformValue.x].current;
				_y = value[TransformValue.y].current;
			}
				
			if(drag_enable_x){
				_x = lerp_with_gap_close(_x,drag_target.x,DRAG_LET_GO_EARLY_LERP_FACTOR,0.1);
				transform_set(_transform,TransformValue.x,_x,false);
				_move_update = true;
			}
				
			if(drag_enable_y){
				_y = lerp_with_gap_close(_y,drag_target.y,DRAG_LET_GO_EARLY_LERP_FACTOR,0.1);
				transform_set(_transform,TransformValue.y,_y,false);
				_move_update = true;
			}
		}
	}
	
	return _move_update;
}
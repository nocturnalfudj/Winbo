/// @function ui_mouse_interaction
/// @summary Handle mouse input over GUI elements each step.
/// @returns {void}
function ui_mouse_interaction() {
	var _pressed,_down,_released;
	var _x_gui,_y_gui;
	var _x_gui_inv,_y_gui_inv;
	var _ms_col_num,_ms_col_inst;
	var _ms_col_any,_ms_col_device_any;
	_ms_col_any = false;
	
	for(var _i=0;_i<MOUSE_INPUT_COUNT;_i++){
		_ms_col_device_any = false;
		
		_pressed = device_mouse_check_button_pressed(_i,mb_any);
		_released = device_mouse_check_button_released(_i,mb_any);
		_down = device_mouse_check_button(_i,mb_any);
	
		if(_down || _pressed || _released){
			mouse_active[_i] = true;
		}
		else{
			mouse_active[_i] = false;
			
			if(IS_MOBILE){
				continue;
			}
		}
		
		#region Get TransformValue.x & TransformValue.y Coords
			_x_gui = device_mouse_x_to_gui(_i);
			_y_gui = device_mouse_y_to_gui(_i);
			_x_gui_inv = _x_gui*gui_scale_inverse;
			_y_gui_inv = _y_gui*gui_scale_inverse;
		
			#region Check if Mouse Moved to Show Crosshair
				if((mouse_gui[_i].x != _x_gui) || (mouse_gui[_i].y != _y_gui)){
					o_input.user[0].gamepad_using = false;
					if((!IS_MOBILE) && ((o_master.dev_mode == false) ^^ (is_mouse_over_debug_overlay() == false))){
						cursor_sprite = spr_crosshair;
					}
				}
			#endregion
			
			mouse_gui[_i].Set(_x_gui,_y_gui);
			mouse_gui_scale_inverted[_i].Set(_x_gui_inv,_y_gui_inv);
		#endregion
		
		#region GUI Collisions
			#region Windows
				_ms_col_num = collision_point_list(_x_gui_inv,_y_gui_inv,o_window,false,true,mouse_collision_list,false);
				for(var _j=0;_j<_ms_col_num;_j++){
					_ms_col_inst = mouse_collision_list[| _j];
					with(_ms_col_inst){
						if((gui) && (camera_visible_gui) && (mouse_collision_enable) && (state != UIState.deactivate) && (state != UIState.activate)){
							mouse_collision = true;
							mouse_device = _i;
							_ms_col_device_any = true;
							_ms_col_any = true;

							window_active = true;
						}
					}
				
					if(_ms_col_device_any){
						break;
					}
				}
				ds_list_clear(mouse_collision_list);
				_ms_col_any = false;
			#endregion
		
			#region Everything Else
				_ms_col_num = collision_point_list(_x_gui_inv,_y_gui_inv,o_ui_object,false,true,mouse_collision_list,false);
				for(var _j=0;_j<_ms_col_num;_j++){
					_ms_col_inst = mouse_collision_list[| _j];
					with(_ms_col_inst){
						if((gui) && (camera_visible_gui) && (state != UIState.deactivate) && (state != UIState.activate)){
							if((mouse_collision_enable) && (!mouse_collision)){
								if((window == noone) || ((window != noone) && (instance_exists(window)) && (window.window_active == true))){
									mouse_collision = true;
									mouse_device = _i;
									_ms_col_device_any = true;
									_ms_col_any = true;
								}
							}
						}
					}
				
					if(_ms_col_device_any){
						break;
					}
				}
				ds_list_clear(mouse_collision_list);
			#endregion
		#endregion
		
		#region Non GUI UI Object Collisions
			_ms_col_num = collision_point_list(mouse_x,mouse_y,o_ui_object,false,true,mouse_collision_list,false);
			for(var _j=0;_j<_ms_col_num;_j++){
				_ms_col_inst = mouse_collision_list[| _j];
				with(_ms_col_inst){
					if((!gui) && (camera_visible) && (state != UIState.deactivate) && (state != UIState.activate)){
						if((mouse_collision_enable) && (!mouse_collision)){
							if((window == noone) || ((window != noone) && (instance_exists(window)) && (window.window_active == true))){
								mouse_collision = true;
								mouse_device = _i;
								_ms_col_device_any = true;
								_ms_col_any = true;
							}
						}
					}
				}
				
				if(_ms_col_device_any){
					break;
				}
			}
			ds_list_clear(mouse_collision_list);
		#endregion
	
		#region Text Buttons
			var _text_button_mouse_collision;
			with(o_text_button){
				_text_button_mouse_collision = false;
				if((state != UIState.deactivate) && (state != UIState.activate)){
					if(gui){
						if((camera_visible_gui) && (point_in_rectangle(_x_gui_inv,_y_gui_inv,x1,y1,x2,y2))){
							_text_button_mouse_collision = true;
						}
					}
					else{
						if((camera_visible) && (point_in_rectangle(mouse_x,mouse_y,x1,y1,x2,y2))){
							_text_button_mouse_collision = true;
						}
					}
				
					if(_text_button_mouse_collision){
						if((mouse_collision_enable) && (!mouse_collision)){
							if((window == noone) || ((window != noone) && (instance_exists(window)) && (window.window_active == true))){
								mouse_collision = true;
								mouse_device = _i;
								
								_ms_col_device_any = true;
								_ms_col_any = true;
							}
						}
					}
				}
			
				if(_ms_col_device_any){
					break;
				}
			}
		#endregion
	}

	mouse_collision_any = _ms_col_any;
}
// Inherit the parent event
event_inherited();

#region Scroll
	with(scroll){
		var _y_min;
		_y_min = y -500;
		position_clamp_min.Set(0,_y_min);
	}
#endregion

#region Tab Creation
	var _x,_y,_x_center,_y_center,_x_width,_y_height;
	with(o_camera){
		_x_center = width_ini_half;
		_y_center = height_ini_half;
		_x_width = width_ini;
		_y_height = height_ini;
	}
	
	#region Save State Flags
		var _has_save_data;
		_has_save_data = false;
	#endregion
	
	#region Layout Variables
		var _y_spacing, _x_offset_per_row, _row;
		_y_spacing = 200;
		_x_offset_per_row = 200;
		_row = 0;
	#endregion
	
	#region Player Poster
		_x = -400;
		_y = 100;
		with(instance_create_layer(_x,_y,"lyr_menu",o_pstr_player_home)){
			transform_parent_anchor_child_id = AnchorTransformChild.center;
		}
	#endregion
	
	#region Game Start Buttons
		if (_has_save_data) {
			//Continue Game
			_x = _row * _x_offset_per_row;
			_y = -100 + (_row * _y_spacing);
			with(instance_create_layer(_x,_y,"lyr_menu",o_txt_btn_continue_game)){
				transform_parent_anchor_child_id = AnchorTransformChild.center;
			}
			_row++;
			
			//New Game
			_x = _row * _x_offset_per_row;
			_y = -100 + (_row * _y_spacing);
			with(instance_create_layer(_x,_y,"lyr_menu",o_txt_btn_new_game)){
				transform_parent_anchor_child_id = AnchorTransformChild.center;
			}
			_row++;
		}
		else {
			//Start Game
			_x = _row * _x_offset_per_row;
			_y = -100 + (_row * _y_spacing);
			with(instance_create_layer(_x,_y,"lyr_menu",o_txt_btn_start_game)){
				transform_parent_anchor_child_id = AnchorTransformChild.center;
			}
			_row++;
		}
	#endregion
	
	#region Level Select Button
		_x = _row * _x_offset_per_row;
		_y = -100 + (_row * _y_spacing);
		with(instance_create_layer(_x,_y,"lyr_menu",o_txt_btn_level_select)){
			transform_parent_anchor_child_id = AnchorTransformChild.center;
		}
		_row++;
	#endregion
	
	#region Options Button
		_x = _row * _x_offset_per_row;
		_y = -100 + (_row * _y_spacing);
		with(instance_create_layer(_x,_y,"lyr_menu",o_txt_btn_options)){
			transform_parent_anchor_child_id = AnchorTransformChild.center;
		}
		_row++;
	#endregion
	
	//Quit
	if(!IS_MOBILE){
		_x = _row * _x_offset_per_row;
		_y = -100 + (_row * _y_spacing);
		with(instance_create_layer(_x,_y,"lyr_menu",o_txt_btn_quit)){
			transform_parent_anchor_child_id = AnchorTransformChild.center;
		}
		_row++;
	}
#endregion
// Inherit the parent event
event_inherited();

#region Scroll
	with(scroll){
		var _y_min;
		_y_min = y - 800;
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
	
	#region Level Action Buttons
		level_action_buttons_create(-200, "lyr_menu", ui_tab_level_select_create_main, AnchorTransformChild.center);
	#endregion
	
	#region Back Button
		_x = 0;
		_y = -100;
		with(instance_create_layer(_x,_y,"lyr_menu",o_txt_btn_back_to_home)){
			transform_parent_anchor_child_id = AnchorTransformChild.bottom_center;
		}
	#endregion
#endregion

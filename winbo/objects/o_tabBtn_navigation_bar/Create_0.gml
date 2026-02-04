//Inherit UI Object Parent
event_inherited();

//Toggle Group
toggle_group = ButtonToggleGroup.navigation_bar;

#region Transform
	var _transform;
	_transform = transform[TransformType.anchor];
	
	//transform_parent_distance_relative_to_scale_x = false;
		
	#region Y Toggle Positions
		//relative to bottom of screen
		y_toggle_on = -70;
		y_toggle_off = -60;
		
		var _y;
		_y = (toggle)? y_toggle_on : y_toggle_off;
		transform_set(_transform,TransformValue.y,_y,false);
		transform_set_rest(_transform,TransformValue.y,_y,false);
	#endregion
	
	#region Colour Toggle Values
		colour_toggle_on = c_ags_red;
		colour_toggle_off = c_white;
		
		var _colour;
		_colour = (toggle)? colour_toggle_on : colour_toggle_off;
		transform_set_rest(_transform,TransformValue.colour,_colour,false);
	#endregion
#endregion

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = tabBtn_navigation_bar_create_main;
	
	state_script[UIState.active][UIStateStage.main] = tabBtn_navigation_bar_active_main;
#endregion
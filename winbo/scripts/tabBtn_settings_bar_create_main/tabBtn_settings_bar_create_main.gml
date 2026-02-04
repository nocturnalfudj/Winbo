function tabBtn_settings_bar_create_main(){
	//Tab Buttn Main
	tabBtn_create_main();
	
	//Main Menu
	ui_tab_settings_create_main();
	
	#region Transform	
		var _camera_height;
		_camera_height = o_camera.height_ini;
		
		var _transform,_y,_colour;
		_transform = transform[TransformType.anchor];
			
		_y = (toggle)? y_toggle_on : y_toggle_off;
		_y += _camera_height
		transform_set_rest(_transform,TransformValue.y,_y,false);
			
		_colour = (toggle)? colour_toggle_on : colour_toggle_off;
		transform_set_rest(_transform,TransformValue.colour,_colour,false);
		
		ui_object_state_set(UIState.idle);
	#endregion
}
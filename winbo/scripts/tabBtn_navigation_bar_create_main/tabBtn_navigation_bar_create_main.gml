/// @function tabBtn_navigation_bar_create_main
/// @summary Create the navigation bar button and associated menu.
function tabBtn_navigation_bar_create_main(){
	//Tab Buttn Main
	tabBtn_create_main();
	
	//Main Menu
	ui_menu_create_main();
	
	#region Transform
		var _transform,_y,_colour;
		_transform = transform[TransformType.anchor];
			
		_y = (toggle)? y_toggle_on : y_toggle_off;
		transform_set_rest(_transform,TransformValue.y,_y,false);
			
		_colour = (toggle)? colour_toggle_on : colour_toggle_off;
		transform_set_rest(_transform,TransformValue.colour,_colour,false);
		
		ui_object_state_set(UIState.idle);
	#endregion
}
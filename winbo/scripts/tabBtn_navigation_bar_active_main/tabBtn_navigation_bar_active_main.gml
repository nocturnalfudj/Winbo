/// @function tabBtn_navigation_bar_active_main
/// @summary Handles active behaviour for navigation bar tab buttons.
/// @returns {void} No return value.
function tabBtn_navigation_bar_active_main(){
	//Tab Button Active
	tabBtn_active_main();
	
	#region Handle Swapping Navigation Bar Buttons
		var _transform,_y,_colour;
		with(o_tabBtn_navigation_bar){
			_transform = transform[TransformType.anchor];
			
			_y = (toggle)? y_toggle_on : y_toggle_off;
			transform_set_rest(_transform,TransformValue.y,_y,false);
			
			_colour = (toggle)? colour_toggle_on : colour_toggle_off;
			transform_set_rest(_transform,TransformValue.colour,_colour,false);
		
			ui_object_state_set(UIState.idle);
		}
	#endregion
}
/// @function tabBtn_settings_bar_active_main
/// @summary Manage navigation bar buttons when the settings tab is active.
function tabBtn_settings_bar_active_main(){
	//Tab Button Active
	tabBtn_active_main();

	#region Handle Swapping Navigation Bar Buttons
		var _camera_height;
		_camera_height = o_camera.height_ini;

		var _transform,_y,_colour;
		with(o_tabBtn_settings_bar){
			_transform = transform[TransformType.anchor];

			_y = (toggle)? y_toggle_on : y_toggle_off;
			_y += _camera_height
			transform_set_rest(_transform,TransformValue.y,_y,false);

			_colour = (toggle)? colour_toggle_on : colour_toggle_off;
			transform_set_rest(_transform,TransformValue.colour,_colour,false);

			ui_object_state_set(UIState.idle);
		}
	#endregion
}
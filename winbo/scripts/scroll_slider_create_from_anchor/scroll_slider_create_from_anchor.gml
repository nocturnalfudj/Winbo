/// @function scroll_slider_create_from_anchor
/// @summary Spawn a slider for a scroll UI element at a specified position.
/// @param {real} _x - X position for the slider.
/// @param {real} _y - Y position for the slider.
/// @param {string} _layer - The layer to create the slider on.
/// @param {bool} _vertical - Whether the slider is vertical.
/// @param {script} _script_create_main - Script to run during the create state.
function scroll_slider_create_from_anchor(_x,_y,_layer,_vertical,_script_create_main){
	//Determine Slider Object
	var _slider_object;
	_slider_object = (_vertical)? o_scroll_slider_vertical : o_scroll_slider_horizontal;
	
	//Create Slider Instance
	var _slider;
	_slider = instance_create_layer(_x,_y,_layer,_slider_object);
	
	//Get Reference to Scroll
	var _scroll;
	_scroll = scroll;
	
	//Setup Slider
	with(_slider){
		//Setup Script
		scroll_slider_setup(_scroll);
		
		//Set Create Main Custom Script
		state_script[UIState.create][UIStateStage.main] = _script_create_main;
	}
}
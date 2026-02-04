/// @function fade_intro_to_menu_create_main
/// @summary Setup the fade from intro to menu screen.
function fade_intro_to_menu_create_main() {
	var _start,_target,_time_current,_time_max,_curve;
	_start = 1;
	_target = 0;
	_time_current = 0;
	_time_max = SECOND * 0.1;
	_curve = ease_quad_out;
	transform_animate(transform[TransformType.anchor],TransformValue.alpha,1,0,_time_current,_time_max,_curve);

	//State to Idle
	ui_object_state_set(UIState.destroy);
}
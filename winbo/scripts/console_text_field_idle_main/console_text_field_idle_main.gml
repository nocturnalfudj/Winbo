/// @function console_text_field_idle_main
/// @summary Manage the console text field while idle on mobile and desktop.
function console_text_field_idle_main() {
	if(IS_MOBILE){
		var _target;
		if(mobile_virtual_keyboard_display == "showing" || mobile_virtual_keyboard_show)
			_target = -(keyboard_virtual_height()*o_ui.gui_scale_inverse + height);
		else{
			_target = 0;
		}
	
		with(o_console){
			var _transform,_transform_value,_target,_time_current,_time_max,_curve;
			_transform = transform[TransformType.anchor];
			_transform_value = TransformValue.y;

			if(_transform.value[_transform_value].animating == false){
				_time_current = 0;
				_time_max = 0.25*SECOND;
				_curve = ease_quad_out;
				transform_animate_from_current_relative_to_rest(_transform,_transform_value,_target,_time_current,_time_max,_curve)
			}
		}
	}
}
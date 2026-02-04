/// @function console_text_field_edit_stop
/// @summary Close the mobile console text field with a recoil animation.
/// @returns {void}
function console_text_field_edit_stop() {
	if(IS_MOBILE){
		with(o_console){
			var _transform,_transform_value,_time_current,_time_max,_curve;
			_transform = transform[TransformType.anchor];
			_transform_value = TransformValue.y;
			_time_current = 0;
			_time_max = 0.25*SECOND;
			_curve = ease_quad_out;
			
			transform_recoil(_transform,_transform_value,_time_current,_time_max,_curve)
		}
	}
}
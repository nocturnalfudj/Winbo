/// @function sldr_camera_shake_setting_active_main
/// @summary Persist camera shake slider adjustments to settings.
function sldr_camera_shake_setting_active_main() {
	if(value_current != value_previous){
		var _value_current;
		_value_current = value_current;
	
		with(o_camera){
			//Update Camera Shake Factor Value
			shake_magnitude_factor = _value_current;
		
			//Save Camera Shake
			camera_save_shake();
		}
	}
}
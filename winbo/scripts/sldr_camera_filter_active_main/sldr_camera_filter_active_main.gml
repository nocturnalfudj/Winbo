/// @function sldr_camera_filter_active_main
/// @summary Update camera filter settings when the slider value changes.
function sldr_camera_filter_active_main() {
	if(value_current != value_previous){
		var _value_current;
		_value_current = value_current;
		
		var _image_setting;
		_image_setting = filter_setting;
	
		with(o_camera){
			//Update Value
			filter_setting[_image_setting] = _value_current;
			
			//Apply
			camera_filter_settings_update_layers();
			
			vignette_noise_shader_update = true;
			
			//Save
			camera_save_filters();
		}
	}
}
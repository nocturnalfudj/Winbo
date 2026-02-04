/// @function sldr_pfx_setting_active_main
/// @summary Slider callback that updates PFX settings when changed.
/// @returns {void}
function sldr_pfx_setting_active_main() {
	if(value_current != value_previous){
		var _value_current;
		_value_current = value_current;
	
		with(o_pfx){
			//Update PFX Setting Value
			pfx_setting = _value_current;
		
			//Save Master Volume Value
			pfx_save();
		}
	}
}
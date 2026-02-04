/// @function btn_lighting_enable_active_main
/// @summary Toggle lighting in the active camera and persist the setting.
function btn_lighting_enable_active_main() {
	var _toggle;
	_toggle = toggle;
	with(o_camera){
		lighting_enable = _toggle;
		
		camera_save();
	}
}
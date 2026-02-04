/// @function btn_vsync_active_main
/// @summary Apply the VSync toggle and save the setting.
function btn_vsync_active_main() {
	if(toggle)
		display_reset(8,true);
	else
		display_reset(8,false);
		
	var _toggle;
	_toggle = toggle;
	with(o_camera){
		vsync = _toggle;
		
		camera_save();
	}
}
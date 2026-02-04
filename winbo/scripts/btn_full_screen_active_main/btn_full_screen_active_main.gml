/// @desc Toggles full-screen mode when this button is activated
function btn_full_screen_active_main() {
	if(toggle)
		window_set_fullscreen(true);
	else{
		window_set_fullscreen(false);
	
		with(o_master){
			//Center Window Alarm
			alarm[MasterAlarm.center_window] = 1;
		}
	}
	
	var _toggle;
	_toggle = toggle;
	with(o_camera){
		fullscreen = _toggle;
		
		camera_save();
	}
}
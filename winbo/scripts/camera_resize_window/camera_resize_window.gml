/// Resize the application window and GUI to the specified dimensions.
function camera_resize_window(_width,_height){
	if(IS_MOBILE && !TESTING_MOBILE_ON_DESKTOP)
		window_set_size(_width,_height);
	else
		window_set_size(_width*WINDOW_SCALE_X,_height*WINDOW_SCALE_Y);

	o_master.alarm[MasterAlarm.center_window] = 2;
	surface_resize(application_surface,_width,_height);
	display_set_gui_size(_width,_height);
}
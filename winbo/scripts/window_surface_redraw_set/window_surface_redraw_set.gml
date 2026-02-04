/// @function window_surface_redraw_set
/// @summary Request a redraw of the window surface for a given duration.
/// @param {real} _time  Time the redraw flag should remain enabled.
/// @returns {void} Nothing.
/// @description
///   Sets a flag used by the UI system to redraw the window surface.
///   Typically called after the window has moved or its contents have changed.
function window_surface_redraw_set(_time){
	surface_redraw = true;
	
	if(_time > alarm[WindowAlarm.surface_redraw_disable]){
		alarm[WindowAlarm.surface_redraw_disable] = _time;
	}
}
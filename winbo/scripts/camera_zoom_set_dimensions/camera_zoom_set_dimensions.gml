/// @function camera_zoom_set_dimensions
/// @summary Update view size variables based on current zoom factors.
/// @returns {void} No return value.
function camera_zoom_set_dimensions() {
	zoom_resultant = zoom_anchor.current * zoom_relative.current;

	width = width_ini * zoom_resultant * image_xscale;
	height = height_ini * zoom_resultant * image_yscale;
	width_half = width/2;
	height_half = height/2;
	camera_set_view_size(view_camera[0],width,height);
}
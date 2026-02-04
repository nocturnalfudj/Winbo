/// @function text_poster_dimensions
/// @summary Update width and height based on current scale.
function text_poster_dimensions() {
	width = width_pre_scale* image_xscale;
	height = height_pre_scale * image_yscale;
	width_half = width/2;
	height_half = height/2;
	
	//Reset calculate_dimensions
	calculate_dimensions = false;
}
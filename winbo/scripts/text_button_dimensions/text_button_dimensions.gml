/// @function text_button_dimensions
/// @summary Update dimension variables for a text button sprite.
/// @returns {void}
function text_button_dimensions() {
	width = width_pre_scale* image_xscale;
	height = height_pre_scale * image_yscale;
	width_half = width/2;
	height_half = height/2;

	switch(alignment_h){
		case fa_left:
			x1 = x;
			x2 = x + width;
		break;
	
		case fa_center:
			x1 = x - width_half;
			x2 = x + width_half;
		break;
	
		case fa_right:
			x1 = x - width;
			x2 = x;
		break;
	}

	switch(alignment_v){
		case fa_top:
			y1 = y;
			y2 = y + height;
		break;
	
		case fa_middle:
			y1 = y - height_half;
			y2 = y + height_half;
		break;
	
		case fa_bottom:
			y1 = y - height;
			y2 = y;
		break;
	}

	//Reset calculate_dimensions
	calculate_dimensions = false;
}
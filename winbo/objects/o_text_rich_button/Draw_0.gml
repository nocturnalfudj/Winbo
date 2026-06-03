if(!gui && camera_visible){
	var _scale_x = image_xscale;
	var _scale_y = image_yscale;
	var _text_offset_x_scaled = text_offset_x * _scale_x;
	var _text_offset_y_scaled = text_offset_y * _scale_y;
	
	text_rich_draw_characters(1, _text_offset_x_scaled, _text_offset_y_scaled);
	
	if(icon_sprite != noone){
		draw_sprite_ext(
			icon_sprite,
			icon_image_index,
			x + icon_x * _scale_x,
			y + icon_y * _scale_y,
			icon_xscale * _scale_x,
			icon_yscale * _scale_y,
			image_angle,
			image_blend,
			image_alpha
		);
	}
}

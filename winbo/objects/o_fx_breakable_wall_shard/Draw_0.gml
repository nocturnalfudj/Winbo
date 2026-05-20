if(source_sprite == noone){
	exit;
}

draw_sprite_part_ext(
	source_sprite,
	source_frame,
	source_left,
	source_top,
	source_width,
	source_height,
	x,
	y,
	image_xscale,
	image_yscale,
	image_blend,
	image_alpha
);

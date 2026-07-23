draw_sprite_ext(
	decor_sprite,
	floor(image_index),
	x,
	y + sin(sway_phase * 1.7) * sway_amount,
	image_xscale,
	image_yscale,
	image_angle,
	c_white,
	image_alpha
);

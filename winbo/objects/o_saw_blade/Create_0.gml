event_inherited();

sprite_current = spr_saw_blade;
image_xscale = 1;
image_yscale = 1;
image_system_setup(sprite_current, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);

damage_amount = 1;
instant_kill = true;

saw_path_point[0] = {
	x: 0,
	y: 0,
	forward: {
		ease_x: ease_quad_in_out,
		ease_y: ease_quad_in_out,
		time: SECOND * 3
	},
	backward: {
		ease_x: ease_quad_in_out,
		ease_y: ease_quad_in_out,
		time: SECOND * 3
	},
};

saw_path_point[1] = {
	x: 320,
	y: 0,
	forward: {
		ease_x: ease_quad_in_out,
		ease_y: ease_quad_in_out,
		time: SECOND * 3
	},
	backward: {
		ease_x: ease_quad_in_out,
		ease_y: ease_quad_in_out,
		time: SECOND * 3
	},
};

saw_path_point_total = array_length(saw_path_point);
saw_path_loop = true;
saw_path_loop_swap_direction = true;
saw_path_direction = 1;
saw_path_point_current = 0;
saw_path_time = 0;
saw_path_point_start_x = 0;
saw_path_point_start_y = 0;
saw_path_x = 0;
saw_path_y = 0;
saw_start_x = x;
saw_start_y = y;

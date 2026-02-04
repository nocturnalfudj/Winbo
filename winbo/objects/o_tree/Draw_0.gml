if(!camera_visible)
	exit;

//Trunk
draw_sprite_ext(sprite_current,sprite_current_frame,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);

#region Distored Leaves
	var strength	= 0.01;
	var size_Rx		= 0.5;
	var size_Ry		= 0.5;
	var size_Gx		= 0.5;
	var size_Gy		= 0.5;
	var R_or_G		= 0.5;
	var spec		= 0;

	var _tex_filter_old = gpu_get_tex_filter();
	gpu_set_tex_filter(true);

	shader_set(shader);
		texture_set_stage(u_distort_tex, distort_tex);
	
		shader_set_uniform_f(u_time, time);
		shader_set_uniform_f(u_strength, strength);
		shader_set_uniform_f(u_size, size_Rx, size_Ry, size_Gx, size_Gy);
		shader_set_uniform_f(u_R_or_G, R_or_G);
		shader_set_uniform_f(u_spec, spec);
	
		draw_sprite_ext(sprite_leaves,0,x + leaves_x,y + leaves_y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	shader_reset();

	gpu_set_tex_filter(_tex_filter_old);
#endregion
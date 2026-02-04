// Inherit the parent event
event_inherited();

//Random Sprite
switch(irandom(3)){
	case 0:
		sprite_current = spr_tree_a_trunk;
		sprite_leaves = spr_tree_a_leaves;
		
		leaves_x = 0;
		leaves_y = -364;
	break;
	
	case 1:
		sprite_current = spr_tree_b_trunk;
		sprite_leaves = spr_tree_b_leaves;
		
		leaves_x = 0;
		leaves_y = -538;
	break;
	
	case 2:
		sprite_current = spr_tree_c_trunk;
		sprite_leaves = spr_tree_c_leaves;
		
		leaves_x = 0;
		leaves_y = -463;
	break;
	
	case 3:
		sprite_current = spr_tree_d_trunk;
		sprite_leaves = spr_tree_d_leaves;
		
		leaves_x = 0;
		leaves_y = -529;
	break;
}

#region Leaves Distortion
	distort_sprite	= spr_flag_distort_no_spec
	distort_tex		= sprite_get_texture(distort_sprite, 0);

	shader			= sh_flag_distortion;
	u_distort_tex	= shader_get_sampler_index(shader, "distort_tex");
	u_time			= shader_get_uniform(shader, "time");
	u_strength		= shader_get_uniform(shader, "strength");
	u_size			= shader_get_uniform(shader, "size");
	u_R_or_G		= shader_get_uniform(shader, "R_or_G");
	u_spec			= shader_get_uniform(shader, "spec");

	time			= random(1);
#endregion

#region Camera Visible Buff Increse
	//To accomodate for the leaves being separate and not considered by the camera visible system
	camera_visible_buff_factor = 7;
	
	camera_visible_buff_width = sprite_width * camera_visible_buff_factor;
	camera_visible_buff_height = sprite_height * camera_visible_buff_factor * 2;
#endregion
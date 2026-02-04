//Background
var _camera_x, _camera_y, _camera_width, _camera_height;
with(o_camera){
	_camera_x = start_x;
	_camera_y = start_y;
	_camera_width = width;
	_camera_height = height;
}

// Draw fluid gradient background for main menu
if(global.game_state == GameState.menu){
	// Update time for animation
	menu_bg_time += delta_time / 1000000;
	
	// Set shader and pass uniforms
	shader_set(sh_menu_background);
	shader_set_uniform_f(menu_bg_shader_uniform_time, menu_bg_time);
	shader_set_uniform_f(menu_bg_shader_uniform_gradient_start, MENU_BG_GRADIENT_START_R, MENU_BG_GRADIENT_START_G, MENU_BG_GRADIENT_START_B);
	shader_set_uniform_f(menu_bg_shader_uniform_gradient_mid, MENU_BG_GRADIENT_MID_R, MENU_BG_GRADIENT_MID_G, MENU_BG_GRADIENT_MID_B);
	shader_set_uniform_f(menu_bg_shader_uniform_gradient_end, MENU_BG_GRADIENT_END_R, MENU_BG_GRADIENT_END_G, MENU_BG_GRADIENT_END_B);
	shader_set_uniform_f(menu_bg_shader_uniform_accent_primary, MENU_BG_ACCENT_PRIMARY_R, MENU_BG_ACCENT_PRIMARY_G, MENU_BG_ACCENT_PRIMARY_B);
	shader_set_uniform_f(menu_bg_shader_uniform_accent_secondary, MENU_BG_ACCENT_SECONDARY_R, MENU_BG_ACCENT_SECONDARY_G, MENU_BG_ACCENT_SECONDARY_B);
	
	// Draw rectangle covering the screen (shader will render the gradient)
	draw_primitive_begin(pr_trianglestrip);
	draw_vertex_texture(0, 0, 0, 0);
	draw_vertex_texture(_camera_width, 0, 1, 0);
	draw_vertex_texture(0, _camera_height, 0, 1);
	draw_vertex_texture(_camera_width, _camera_height, 1, 1);
	draw_primitive_end();
	
	shader_reset();
}
else if(room != r_intro && room != r_loading_app){
	//Offset
	var _offset_y;
	_offset_y = -2000;
	
	var _tex_filter_old = gpu_get_tex_filter();
	gpu_set_tex_filter(false);
	
	// Draw all layers with their parallax factors
	director_draw_parallax_layer(spr_bg_forest_layer_5, _camera_x, _camera_y, _camera_width, _camera_height, 1.0, 1.0, _offset_y);
	director_draw_parallax_layer(spr_bg_forest_layer_4, _camera_x, _camera_y, _camera_width, _camera_height, 0.9, 0.9, _offset_y);
	director_draw_parallax_layer(spr_bg_forest_layer_3, _camera_x, _camera_y, _camera_width, _camera_height, 0.8, 0.8, _offset_y);
	director_draw_parallax_layer(spr_bg_forest_layer_2, _camera_x, _camera_y, _camera_width, _camera_height, 0.7, 0.7, _offset_y);
	director_draw_parallax_layer(spr_bg_forest_layer_1, _camera_x, _camera_y, _camera_width, _camera_height, 0.6, 0.6, _offset_y);
	director_draw_parallax_layer(spr_bg_forest_layer_0, _camera_x, _camera_y, _camera_width, _camera_height, 0.5, 0.5, _offset_y);
	
	gpu_set_tex_filter(_tex_filter_old);
}
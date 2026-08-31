//Background
var _camera_x, _camera_y, _camera_width, _camera_height;
with(o_camera){
	_camera_x = start_x;
	_camera_y = start_y;
	_camera_width = width;
	_camera_height = height;
}

// Keep the menu background alive through the menu->start fade-out.
var _draw_menu_background;
var _draw_menu_transition_background;
_draw_menu_transition_background =
	room == r_game
	&& instance_exists(o_fade_intro_to_menu)
	&& (global.game_state == GameState.loading_app || global.game_state_target == GameState.menu);

_draw_menu_background =
	global.game_state == GameState.menu
	|| global.game_state == GameState.start
	|| _draw_menu_transition_background;

var _draw_environment_background;
_draw_environment_background = room != r_boot && room != r_intro && room != r_loading_app;

// Draw fluid gradient background for main menu
if(_draw_menu_background){
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
else if(_draw_environment_background){
	var _environment_data;
	_environment_data = environment[environment_current];
	if(is_undefined(_environment_data)){
		_environment_data = environment[Environment.default_environment];
	}
	
	var _tex_filter_old = gpu_get_tex_filter();
	gpu_set_tex_filter(false);
	
	var _back_layers = _environment_data.background_back_layers;
	if(is_undefined(_back_layers))
		_back_layers = [];
	var _back_layer_count = array_length(_back_layers);
	for(var _i = 0; _i < _back_layer_count; _i++){
		var _layer = _back_layers[_i];
		switch(_layer.mode){
			case "view_cover":
				var _view_scale = max(
					_camera_width / sprite_get_width(_layer.sprite),
					_camera_height / sprite_get_height(_layer.sprite)
				);
				var _view_draw_x = _camera_x
					+ (_camera_width - sprite_get_width(_layer.sprite) * _view_scale) * 0.5;
				var _view_draw_y = _camera_y + _camera_height
					- sprite_get_height(_layer.sprite) * _view_scale;
				draw_sprite_ext(
					_layer.sprite,
					0,
					_view_draw_x,
					_view_draw_y,
					_view_scale,
					_view_scale,
					0,
					c_white,
					1
				);
			break;

			case "normal":
				director_draw_parallax_layer(
					_layer.sprite,
					_camera_x,
					_camera_y,
					_camera_width,
					_camera_height,
					_layer.parallax_x,
					_layer.parallax_y,
					_layer.offset_y,
					_layer.repeat_x,
					_layer.clamp_top,
					_layer.clamp_bottom
				);
			break;

			case "room_bottom":
				director_draw_parallax_layer(
					_layer.sprite,
					_camera_x,
					_camera_y,
					_camera_width,
					_camera_height,
					_layer.parallax_x,
					_layer.parallax_y,
					_layer.offset_y,
					_layer.repeat_x,
					_layer.clamp_top,
					_layer.clamp_bottom,
					true
				);
			break;
			
			case "variant_once":
				director_draw_parallax_layer_variant(
					_layer.sprite_first,
					_layer.sprite_loop,
					_camera_x,
					_camera_y,
					_camera_width,
					_camera_height,
					_layer.parallax_x,
					_layer.parallax_y,
					_layer.offset_y,
					_layer.clamp_top,
					_layer.clamp_bottom
				);
			break;
			
			case "animated":
				var _frame_count = sprite_get_number(_layer.sprite);
				var _frame = 0;
				if(_frame_count > 1){
					_frame = floor(bg_anim_time_seconds * _layer.fps) mod _frame_count;
				}

				director_draw_parallax_layer_frame(
					_layer.sprite,
					_frame,
					_camera_x,
					_camera_y,
					_camera_width,
					_camera_height,
					_layer.parallax_x,
					_layer.parallax_y,
					_layer.offset_y,
					_layer.clamp_top,
					_layer.clamp_bottom
				);
			break;
			
			case "anchored_animated_overlay":
				var _overlay_frame_count = sprite_get_number(_layer.animated_sprite);
				var _overlay_frame = 0;
				if(_overlay_frame_count > 1){
					_overlay_frame = floor(bg_anim_time_seconds * _layer.fps) mod _overlay_frame_count;
				}

				director_draw_parallax_layer_anchored_animated(
					_layer.base_sprite,
					_layer.animated_sprite,
					_overlay_frame,
					_camera_x,
					_camera_y,
					_camera_width,
					_camera_height,
					_layer.parallax_x,
					_layer.parallax_y,
					_layer.offset_y,
					_layer.loop_width,
					_layer.anchor_x,
					_layer.anchor_sprite_x,
					_layer.clamp_top,
					_layer.clamp_bottom
				);
			break;
		}
	}
	
	gpu_set_tex_filter(_tex_filter_old);
}

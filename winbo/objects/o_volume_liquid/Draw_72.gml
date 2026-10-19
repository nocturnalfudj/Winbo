event_inherited();
if (!camera_visible) exit;

// Draw Begin owns sizing for all six surfaces, including after zoom, window
// resizing, volume resizing, or loss of a GPU surface.
render_scale = o_ui.gui_scale / o_camera.zoom_resultant;
render_height_buffer = max(500, bbox_bottom - bbox_top);
var _width = max(1, ceil((bbox_right - bbox_left) * render_scale));
var _height = max(1, ceil((bbox_bottom - bbox_top + render_height_buffer) * render_scale));
underwater_background_surface = liquid_surface_update(underwater_background_surface, _width, _height);
water_mask_surface = liquid_surface_update(water_mask_surface, _width, _height);
underwater_surface = liquid_surface_update(underwater_surface, _width, _height);
underwater_composite_surface = liquid_surface_update(underwater_composite_surface, _width, _height);
reflection_surface = liquid_surface_update(reflection_surface, _width, _height);
reflection_composite_surface = liquid_surface_update(reflection_composite_surface, _width, _height);
cached_surf_w = _width;
cached_surf_h = _height;

// The same wave mask is used by the background, submerged scene and reflection.
surface_set_target(water_mask_surface);
draw_clear_alpha(c_black, 0);
draw_primitive_begin(pr_trianglestrip);
var _k = (2 * pi) / wave_len_px;
for (var _i = 0; _i <= wave_segments; _i++) {
	var _vx = _i * wave_dx;
	var _u = _i / wave_segments;
	var _taper = power(sin(pi * _u), wave_edge_power);
	var _wave = sin(_k * _vx + wave_phase) * wave_amp_px * _taper;
	var _displacement = wave_sim_enable ? wave_y[_i] : 0;
	var _top = (_wave + _displacement + render_height_buffer) * render_scale;
	draw_vertex_colour(_vx * render_scale, _top, c_white, 1);
	draw_vertex_colour(_vx * render_scale, _height, c_white, 1);
}
draw_primitive_end();
surface_reset_target();

surface_set_target(underwater_background_surface);
draw_clear_alpha(c_black, 0);
gpu_set_colorwriteenable(false, false, false, true);
draw_surface(water_mask_surface, 0, 0);
gpu_set_colorwriteenable(true, true, true, true);
gpu_set_blendmode_ext(bm_dest_alpha, bm_zero);
draw_sprite_tiled_ext(sprite_index, 0, texture_x, texture_y, 1, 1, c_white, 1);
gpu_set_blendmode(bm_normal);
surface_reset_target();

draw_surface_ext(underwater_background_surface, bbox_left, bbox_top - render_height_buffer,
	1 / render_scale, 1 / render_scale, 0, c_white, 1);

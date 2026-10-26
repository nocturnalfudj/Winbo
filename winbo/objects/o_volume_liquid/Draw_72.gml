// Only the connected-body owner draws the shared union.
if(liquid_body.owner != id || !camera_visible) exit;

// Draw Begin owns sizing for all six surfaces, including after zoom, window
// resizing, volume resizing, or loss of a GPU surface.
// Capture addresses application-surface pixels. Read its actual projection
// instead of reconstructing it from UI scale and a cached zoom value.
render_scale = surface_get_width(application_surface) / camera_get_view_width(view_camera[0]);
render_height_buffer = max(500, liquid_body.bottom - liquid_body.top);
var _width = max(1, ceil((liquid_body.right - liquid_body.left) * render_scale));
var _height = max(1, ceil((liquid_body.bottom - liquid_body.top + render_height_buffer) * render_scale));
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
for(var _ci = 0; _ci < array_length(liquid_body.cells); _ci++){
	var _cell = liquid_body.cells[_ci];
	var _surface = liquid_body.surfaces[_cell.surface];
	var _steps = max(1, ceil((_cell.right - _cell.left) / wave_segment_px));
	draw_primitive_begin(pr_trianglestrip);
	for(var _i = 0; _i <= _steps; _i++){
		var _x = lerp(_cell.left, _cell.right, _i / _steps);
		var _y = liquid_surface_height(_surface, _x);
		draw_vertex_colour((_x - liquid_body.left) * render_scale,
			(_y - liquid_body.top + render_height_buffer) * render_scale, c_white, 1);
		draw_vertex_colour((_x - liquid_body.left) * render_scale,
			(_cell.bottom - liquid_body.top + render_height_buffer) * render_scale, c_white, 1);
	}
	draw_primitive_end();
}
surface_reset_target();

surface_set_target(underwater_background_surface);
draw_clear_alpha(c_black, 0);
gpu_set_colorwriteenable(false, false, false, true);
draw_surface(water_mask_surface, 0, 0);
gpu_set_colorwriteenable(true, true, true, true);
gpu_set_blendmode_ext(bm_dest_alpha, bm_zero);
draw_sprite_tiled_ext(sprite_index, 0, texture_x - liquid_body.left * render_scale,
	texture_y - (liquid_body.top - render_height_buffer) * render_scale, 1, 1, c_white, 1);
gpu_set_blendmode(bm_normal);
surface_reset_target();

draw_surface_ext(underwater_background_surface, liquid_body.left, liquid_body.top - render_height_buffer,
	1 / render_scale, 1 / render_scale, 0, c_white, 1);

// Only the connected-body owner draws the shared union.
if(liquid_body.owner != id || !camera_visible) exit;

// Draw Begin owns sizing for all six surfaces, including after zoom, window
// resizing, volume resizing, or loss of a GPU surface.
// Capture addresses application-surface pixels. Read its actual projection
// instead of reconstructing it from UI scale and a cached zoom value.
render_scale = surface_get_width(application_surface) / camera_get_view_width(view_camera[0]);
render_height_buffer = max(500, liquid_body.bottom - liquid_body.top);

// The surfaces cover a fixed-size window: the body with its reflection headroom,
// capped at one view, so a tall or wide body never allocates its whole area.
// The window slides inside the body to keep the on-screen part covered. Its
// pixel size depends only on the body, the zoom and the resolution; camera
// movement must never change it, because resizing six surfaces is a hitch.
var _camera = view_camera[0];
var _extent_top = liquid_body.top - render_height_buffer;
var _window_width = min(liquid_body.right - liquid_body.left, camera_get_view_width(_camera));
var _window_height = min(liquid_body.bottom - _extent_top, camera_get_view_height(_camera));
render_left = clamp(camera_get_view_x(_camera), liquid_body.left, liquid_body.right - _window_width);
render_top = clamp(camera_get_view_y(_camera), _extent_top, liquid_body.bottom - _window_height);
// A whole-pixel product can land a hair above its integer; that must not add a pixel.
var _width = max(1, ceil(_window_width * render_scale - 0.01));
var _height = max(1, ceil(_window_height * render_scale - 0.01));
underwater_background_surface = liquid_surface_update(underwater_background_surface, _width, _height);
water_mask_surface = liquid_surface_update(water_mask_surface, _width, _height);
underwater_surface = liquid_surface_update(underwater_surface, _width, _height);
underwater_composite_surface = liquid_surface_update(underwater_composite_surface, _width, _height);
reflection_surface = liquid_surface_update(reflection_surface, _width, _height);
reflection_composite_surface = liquid_surface_update(reflection_composite_surface, _width, _height);
cached_surf_w = _width;
cached_surf_h = _height;

// The window can reach past the screen edge. Every pass fills only the part on
// screen, padded so a ripple sample at its edge still lands on drawn pixels;
// the rest of each surface stays cleared. Allocation is fixed, fill follows
// the screen.
var _view_x = camera_get_view_x(_camera);
var _view_y = camera_get_view_y(_camera);
var _pad = ceil(submerged_ripple_strength) + 4;
var _clip_right = min(_width, ceil((_view_x + camera_get_view_width(_camera) - render_left) * render_scale) + _pad);
var _clip_bottom = min(_height, ceil((_view_y + camera_get_view_height(_camera) - render_top) * render_scale) + _pad);
render_clip_x = max(0, floor((_view_x - render_left) * render_scale) - _pad);
render_clip_y = max(0, floor((_view_y - render_top) * render_scale) - _pad);
render_clip_w = max(0, _clip_right - render_clip_x);
render_clip_h = max(0, _clip_bottom - render_clip_y);
// Inside the cull margin but off screen: nothing to draw.
if(render_clip_w <= 0 || render_clip_h <= 0) exit;

// The same wave mask is used by the background, submerged scene and reflection.
var _clip_world_left = render_left + render_clip_x / render_scale;
var _clip_world_right = render_left + _clip_right / render_scale;
var _clip_world_bottom = render_top + _clip_bottom / render_scale;
// A crest far above the rectangle is flattened; nothing that steep reaches it.
var _strip_top_min = render_clip_y - 256;
surface_set_target(water_mask_surface);
draw_clear_alpha(c_black, 0);
for(var _ci = 0; _ci < array_length(liquid_body.cells); _ci++){
	var _cell = liquid_body.cells[_ci];
	if(_cell.right <= _clip_world_left || _cell.left >= _clip_world_right) continue;
	var _strip_bottom = (min(_cell.bottom, _clip_world_bottom) - render_top) * render_scale;
	if(_strip_bottom <= render_clip_y) continue;
	var _surface = liquid_body.surfaces[_cell.surface];
	var _steps = max(1, ceil((_cell.right - _cell.left) / wave_segment_px));
	// Keep the whole cell's vertex grid so the contour never shifts with the camera.
	var _step_width = (_cell.right - _cell.left) / _steps;
	var _step_first = clamp(floor((_clip_world_left - _cell.left) / _step_width), 0, _steps);
	var _step_last = clamp(ceil((_clip_world_right - _cell.left) / _step_width), 0, _steps);
	draw_primitive_begin(pr_trianglestrip);
	for(var _i = _step_first; _i <= _step_last; _i++){
		var _x = lerp(_cell.left, _cell.right, _i / _steps);
		var _y = liquid_surface_height(_surface, _x);
		draw_vertex_colour((_x - render_left) * render_scale,
			clamp((_y - render_top) * render_scale, _strip_top_min, _strip_bottom), c_white, 1);
		draw_vertex_colour((_x - render_left) * render_scale, _strip_bottom, c_white, 1);
	}
	draw_primitive_end();
}
surface_reset_target();

surface_set_target(underwater_background_surface);
draw_clear_alpha(c_black, 0);
gpu_set_colorwriteenable(false, false, false, true);
draw_surface_part(water_mask_surface, render_clip_x, render_clip_y, render_clip_w, render_clip_h,
	render_clip_x, render_clip_y);
gpu_set_colorwriteenable(true, true, true, true);
gpu_set_blendmode_ext(bm_dest_alpha, bm_zero);
// Tile across the visible rectangle only; one tile origin sits at the scrolled offset.
var _tile_width = sprite_get_width(sprite_index);
var _tile_height = sprite_get_height(sprite_index);
var _tile_origin_x = texture_x - render_left * render_scale;
var _tile_origin_y = texture_y - render_top * render_scale;
var _tile_left = _tile_origin_x + floor((render_clip_x - _tile_origin_x) / _tile_width) * _tile_width;
var _tile_top = _tile_origin_y + floor((render_clip_y - _tile_origin_y) / _tile_height) * _tile_height;
for(var _tile_y = _tile_top; _tile_y < _clip_bottom; _tile_y += _tile_height){
	for(var _tile_x = _tile_left; _tile_x < _clip_right; _tile_x += _tile_width){
		draw_sprite_ext(sprite_index, 0, _tile_x, _tile_y, 1, 1, 0, c_white, 1);
	}
}
gpu_set_blendmode(bm_normal);
surface_reset_target();

draw_surface_ext(underwater_background_surface, render_left, render_top,
	1 / render_scale, 1 / render_scale, 0, c_white, 1);

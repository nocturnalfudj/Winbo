// Only the connected-body owner draws the shared union.
if(liquid_body.owner != id || !camera_visible) exit;
// Inside the cull margin but off screen: nothing to draw.
if(render_clip_w <= 0 || render_clip_h <= 0) exit;

liquid_scene_capture();

// Ripples stay anchored to the whole body while the surface window slides.
var _body_width = liquid_body.right - liquid_body.left;
var _body_height = liquid_body.bottom - liquid_body.top + render_height_buffer;
var _frame_x = (render_left - liquid_body.left) / _body_width;
var _frame_y = (render_top - liquid_body.top + render_height_buffer) / _body_height;
var _frame_width = cached_surf_w / render_scale / _body_width;
var _frame_height = cached_surf_h / render_scale / _body_height;

// Every pass fills only the on-screen rectangle set in Draw Begin.
var _clip_x = render_clip_x;
var _clip_y = render_clip_y;
var _clip_w = render_clip_w;
var _clip_h = render_clip_h;

surface_set_target(underwater_composite_surface);
draw_clear_alpha(c_black, 0);
gpu_set_colorwriteenable(false, false, false, true);
draw_surface_part(water_mask_surface, _clip_x, _clip_y, _clip_w, _clip_h, _clip_x, _clip_y);
gpu_set_colorwriteenable(true, true, true, true);
gpu_set_blendmode_ext(bm_dest_alpha, bm_zero);
shader_set(sh_liquid_ripple);
shader_set_uniform_f(submerged_ripple_uniform_time, submerged_ripple_time);
shader_set_uniform_f(submerged_ripple_uniform_texel, 1 / cached_surf_w, 1 / cached_surf_h);
shader_set_uniform_f(submerged_ripple_uniform_strength, submerged_ripple_strength);
shader_set_uniform_f(submerged_ripple_uniform_body_frame, _frame_x, _frame_y, _frame_width, _frame_height);
shader_set_uniform_f(submerged_ripple_uniform_fade_top, 0, 0);
shader_set_uniform_f(submerged_ripple_uniform_reflection_depth, 0, 0);
draw_surface_part(underwater_surface, _clip_x, _clip_y, _clip_w, _clip_h, _clip_x, _clip_y);
shader_reset();
gpu_set_blendmode(bm_normal);
surface_reset_target();

var _left = render_left;
var _top = render_top;
var _scale = 1 / render_scale;
draw_surface_ext(underwater_composite_surface, _left, _top, _scale, _scale, 0, c_white, 1);
draw_surface_ext(underwater_background_surface, _left, _top, _scale, _scale, 0, c_white, 0.3);

if (reflection_enable) {
	// Remove submerged source pixels before mirroring the captured scene.
	// Outside the rectangle the capture is transparent, so a clear matches it.
	surface_set_target(reflection_surface);
	draw_clear_alpha(c_black, 0);
	gpu_set_blendmode_ext(bm_one, bm_zero);
	draw_surface_part(underwater_surface, _clip_x, _clip_y, _clip_w, _clip_h, _clip_x, _clip_y);
	gpu_set_blendmode_ext(bm_zero, bm_inv_src_alpha);
	draw_surface_part(water_mask_surface, _clip_x, _clip_y, _clip_w, _clip_h, _clip_x, _clip_y);
	gpu_set_blendmode(bm_normal);
	surface_reset_target();

	// Each exposed surface reflects into its own vertical wet interval. The
	// shared union mask clips waves and holes after these disjoint strips.
	surface_set_target(reflection_composite_surface);
	draw_clear_alpha(c_black, 0);
	gpu_set_blendmode_ext(bm_one, bm_zero);
	shader_set(sh_liquid_ripple);
	shader_set_uniform_f(submerged_ripple_uniform_time, submerged_ripple_time);
	shader_set_uniform_f(submerged_ripple_uniform_texel, 1 / cached_surf_w, 1 / cached_surf_h);
	shader_set_uniform_f(submerged_ripple_uniform_strength, submerged_ripple_strength);
	shader_set_uniform_f(submerged_ripple_uniform_body_frame, _frame_x, _frame_y, _frame_width, _frame_height);
	shader_set_uniform_f(submerged_ripple_uniform_fade_top,
		render_capture_top, 64 * render_scale / cached_surf_h);
	for(var _ci = 0; _ci < array_length(liquid_body.cells); _ci++){
		var _cell = liquid_body.cells[_ci];
		// Mirror only the destination inside the on-screen rectangle.
		var _sx = max((_cell.left - render_left) * render_scale, _clip_x);
		var _sx_end = min((_cell.right - render_left) * render_scale, _clip_x + _clip_w);
		var _sy = (_cell.top - render_top) * render_scale;
		var _height = min((_cell.bottom - _cell.top) * render_scale, _sy);
		var _dest_top = max(_sy, _clip_y);
		var _dest_bottom = min(_sy + _height, _clip_y + _clip_h);
		if(_sx_end <= _sx || _dest_bottom <= _dest_top) continue;
		// Reflection depth is local to this exposed surface, including the
		// lower edge inside a ring. Never carry a bright reflected rectangle
		// down the entire column when neighbouring cells have a higher top.
		shader_set_uniform_f(submerged_ripple_uniform_reflection_depth,
			_sy / cached_surf_h, reflection_fade_depth * render_scale / cached_surf_h);
		// Source ends at the nominal surface; invert around that surface.
		draw_surface_part_ext(reflection_surface, _sx, 2 * _sy - _dest_bottom,
			_sx_end - _sx, _dest_bottom - _dest_top,
			_sx, _dest_bottom, 1, -1, c_white, 1);
	}
	shader_reset();
	// Clip the mirrored image to the current wave contour. Apply reflection
	// opacity only once, when compositing, without redrawing the submerged scene.
	gpu_set_blendmode_ext(bm_zero, bm_src_alpha);
	draw_surface_part(water_mask_surface, _clip_x, _clip_y, _clip_w, _clip_h, _clip_x, _clip_y);
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
	draw_surface_ext(reflection_composite_surface, _left, _top, _scale, _scale, 0, c_white, reflection_alpha);
}

if (o_master.dev_mode) draw_bounding_box(true);

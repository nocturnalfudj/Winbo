// Only the connected-body owner draws the shared union.
if(liquid_body.owner != id || !camera_visible) exit;

liquid_scene_capture();

// Ripples stay anchored to the whole body while the surfaces follow the view.
var _body_width = liquid_body.right - liquid_body.left;
var _body_height = liquid_body.bottom - liquid_body.top + render_height_buffer;
var _frame_x = (render_left - liquid_body.left) / _body_width;
var _frame_y = (render_top - liquid_body.top + render_height_buffer) / _body_height;
var _frame_width = cached_surf_w / render_scale / _body_width;
var _frame_height = cached_surf_h / render_scale / _body_height;

surface_set_target(underwater_composite_surface);
draw_clear_alpha(c_black, 0);
gpu_set_colorwriteenable(false, false, false, true);
draw_surface(water_mask_surface, 0, 0);
gpu_set_colorwriteenable(true, true, true, true);
gpu_set_blendmode_ext(bm_dest_alpha, bm_zero);
shader_set(sh_liquid_ripple);
shader_set_uniform_f(submerged_ripple_uniform_time, submerged_ripple_time);
shader_set_uniform_f(submerged_ripple_uniform_texel, 1 / cached_surf_w, 1 / cached_surf_h);
shader_set_uniform_f(submerged_ripple_uniform_strength, submerged_ripple_strength);
shader_set_uniform_f(submerged_ripple_uniform_body_frame, _frame_x, _frame_y, _frame_width, _frame_height);
shader_set_uniform_f(submerged_ripple_uniform_fade_top, 0, 0);
shader_set_uniform_f(submerged_ripple_uniform_reflection_depth, 0, 0);
draw_surface(underwater_surface, 0, 0);
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
	surface_copy(reflection_surface, 0, 0, underwater_surface);
	surface_set_target(reflection_surface);
	gpu_set_blendmode_ext(bm_zero, bm_inv_src_alpha);
	draw_surface(water_mask_surface, 0, 0);
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
		// Cells and their mirrored source are clipped to the on-screen slice.
		var _cell_left = max(_cell.left, render_left);
		var _cell_right = min(_cell.right, render_right);
		var _sx = (_cell_left - render_left) * render_scale;
		var _sy = (_cell.top - render_top) * render_scale;
		var _height = min((_cell.bottom - _cell.top) * render_scale, _sy);
		if(_cell_right <= _cell_left || _height <= 0 || _sy >= cached_surf_h) continue;
		// Reflection depth is local to this exposed surface, including the
		// lower edge inside a ring. Never carry a bright reflected rectangle
		// down the entire column when neighbouring cells have a higher top.
		shader_set_uniform_f(submerged_ripple_uniform_reflection_depth,
			_sy / cached_surf_h, reflection_fade_depth * render_scale / cached_surf_h);
		// Source ends at the nominal surface; invert around that surface.
		draw_surface_part_ext(reflection_surface, _sx, _sy - _height,
			(_cell_right - _cell_left) * render_scale, _height,
			_sx, _sy + _height, 1, -1, c_white, 1);
	}
	shader_reset();
	// Clip the mirrored image to the current wave contour. Apply reflection
	// opacity only once, when compositing, without redrawing the submerged scene.
	gpu_set_blendmode_ext(bm_zero, bm_src_alpha);
	draw_surface(water_mask_surface, 0, 0);
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
	draw_surface_ext(reflection_composite_surface, _left, _top, _scale, _scale, 0, c_white, reflection_alpha);
}

if (o_master.dev_mode) draw_bounding_box(true);

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

// Every pass reads only the on-screen rectangle set in Draw Begin and draws
// straight to the target; the shader clips against the wave mask.
var _clip_x = render_clip_x;
var _clip_y = render_clip_y;
var _clip_w = render_clip_w;
var _clip_h = render_clip_h;
var _left = render_left;
var _top = render_top;
var _scale = 1 / render_scale;
var _mask_texture = surface_get_texture(water_mask_surface);

shader_set(sh_liquid_ripple);
texture_set_stage(submerged_ripple_sampler_mask, _mask_texture);
shader_set_uniform_f(submerged_ripple_uniform_time, submerged_ripple_time);
shader_set_uniform_f(submerged_ripple_uniform_texel, 1 / cached_surf_w, 1 / cached_surf_h);
shader_set_uniform_f(submerged_ripple_uniform_strength, submerged_ripple_strength);
shader_set_uniform_f(submerged_ripple_uniform_body_frame, _frame_x, _frame_y, _frame_width, _frame_height);
shader_set_uniform_f(submerged_ripple_uniform_fade_top, 0, 0);
shader_set_uniform_f(submerged_ripple_uniform_reflection_depth, 0, 0);
shader_set_uniform_f(submerged_ripple_uniform_mask_mode, 0, 1, 0);
draw_surface_part_ext(underwater_surface, _clip_x, _clip_y, _clip_w, _clip_h,
	_left + _clip_x * _scale, _top + _clip_y * _scale, _scale, _scale, c_white, 1);
shader_reset();

liquid_tiles_draw(0.3);

if (reflection_enable) {
	// Each exposed surface reflects into its own vertical wet interval. The
	// shader drops submerged source pixels and clips the mirror to the current
	// wave contour, so these disjoint strips draw straight to the target.
	shader_set(sh_liquid_ripple);
	texture_set_stage(submerged_ripple_sampler_mask, _mask_texture);
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
		// A source row v lands on mask row 2 * surface - v below the surface.
		shader_set_uniform_f(submerged_ripple_uniform_mask_mode, 2 * _sy / cached_surf_h, -1, 1);
		// Source ends at the nominal surface; invert around that surface.
		// Reflection opacity is the draw alpha, applied once per pixel.
		draw_surface_part_ext(underwater_surface, _sx, 2 * _sy - _dest_bottom,
			_sx_end - _sx, _dest_bottom - _dest_top,
			_left + _sx * _scale, _top + _dest_bottom * _scale, _scale, -_scale,
			c_white, reflection_alpha);
	}
	shader_reset();
}

if (o_master.dev_mode) {
	for(var _i = 0; _i < array_length(liquid_body.rects); _i++){
		var _r = liquid_body.rects[_i];
		draw_rectangle_colour(_r.left, _r.top, _r.right, _r.bottom,
			c_ags_red, c_ags_red, c_ags_red, c_ags_red, true);
	}
	draw_circle_colour(x, y, 3, c_ags_red, c_ags_red, false);
}
